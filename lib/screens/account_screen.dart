import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/providers/auth.dart';
import 'package:magelan/screens/about.dart';
import 'package:magelan/screens/edit_account_screen.dart';
import 'package:magelan/screens/login_screen.dart';
import 'package:magelan/screens/signup_screen.dart';
import 'package:magelan/screens/tabs_screen.dart';
import 'package:magelan/screens/use.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? _name;
  String? _imgUrl;
  String? _token;

  Future<void> userData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {}

    Map<String, dynamic> extractedUserData =
        jsonDecode(prefs.getString("userData").toString())
            as Map<String, dynamic>;
    setState(() {
      _name = extractedUserData['name'].toString();
      _imgUrl = extractedUserData['imgUrl'].toString();
      _token = extractedUserData['token'].toString();
    });
  }

  @override
  void initState() {
    userData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _token!=null? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
                Container(
                  padding:const EdgeInsets.only(top: 40,bottom: 10),
                  height: 200,
                  width: double.infinity,
                  child: Image.network("http://159.223.24.4/storage/"+_imgUrl.toString()),
                ),
            Text(
                    _name.toString(),
                    style:const TextStyle(color: MyColors.primaryColor),
                  ),
            Expanded(
              child: Card(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(EditAccountScreen.routeName);
                          },
                          title: const Text("تعديل الحساب"),
                          leading: const Icon(
                            Icons.edit_outlined,
                            color: MyColors.primaryColor,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: MyColors.textColor,
                            size: 17,
                          ),
                        ),
                         const Divider(),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(AbouteScreen.routeName);
                          },
                          title: const Text("عن التطبيق"),
                          // ignore: prefer_const_constructors
                          leading: Icon(
                            Icons.people_alt,
                            color: MyColors.primaryColor,
                          ),
                        ),
                          const Divider(),                       
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(UseScreen.routeName);
                          },
                          title: const Text(" الخصوصية وسياسة الاستخدام"),
                          // ignore: prefer_const_constructors
                          leading: Icon(
                            Icons.policy,
                            color: MyColors.primaryColor,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () {
                            Provider.of<Auth>(context, listen: false).logout();
                            Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
                          },
                          title: const Text("تسجيل الخروج"),
                          // ignore: prefer_const_constructors
                          leading: Icon(
                            Icons.logout,
                            color: MyColors.primaryColor,
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ):Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
                SafeArea(
                  child: Container(
                    color: MyColors.backgraoundColor,
                    padding:const EdgeInsets.only(top: 0,bottom: 10),
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                              'assets/images/profile.jpg',
                            ),
                  ),
                ),
            Expanded(
              child: Card(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[

                       const Text("لرؤية بيانات حسابك والتعديل عليها عليك بتسجيل الدخول او التسجيل"),
                       const Divider(),
                        ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(SignupScreen.routeName);
                          },
                          title: const Text(" تسجيل"),
                          leading: const Icon(
                            Icons.app_registration_rounded,
                            color: MyColors.primaryColor,
                          ),
                         
                        ),
                        
                        const Divider(),
                        ListTile(
                           onTap: () {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                          },
                          title: const Text("تسجيل الدخول"),
                          // ignore: prefer_const_constructors
                          leading: Icon(
                            Icons.login_sharp,
                            color: MyColors.primaryColor,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(AbouteScreen.routeName);
                          },
                          title: const Text("عن التطبيق"),
                          // ignore: prefer_const_constructors
                          leading: Icon(
                            Icons.people_alt,
                            color: MyColors.primaryColor,
                          ),
                        ),
                         const Divider(),                      
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(UseScreen.routeName);
                          },
                          title: const Text(" الخصوصية وسياسة الاستخدام"),
                          // ignore: prefer_const_constructors
                          leading: Icon(
                            Icons.policy,
                            color: MyColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}

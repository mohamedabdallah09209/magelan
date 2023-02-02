import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/models/http_exception.dart';
import 'package:magelan/providers/auth.dart';
import 'package:magelan/screens/forgot_password.dart';
import 'package:magelan/screens/signup_screen.dart';
import 'package:magelan/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: unused_field
  static const routeName = '/login-screen';
  bool ischecked = true;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "تسجيل الدخول",
            style: TextStyle(
              color: MyColors.textColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: MyColors.backgraoundColor,
          elevation: 0,
          
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              color: MyColors.backgraoundColor,
              width: double.infinity,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // ignore: prefer_const_literals_to_create_immutables

                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                          ),
                        ),
                      ),
                     
                      const AuthCard(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  // ignore: prefer_final_fields
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حدث خطأ !'),
        content: Text(message),
        actions: <Widget>[
          MaterialButton(
            child: const Text('تم'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  // ignore: unused_element
  Future<void> _submit() async {
FocusManager.instance.primaryFocus!.unfocus();
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(
        _authData['email'].toString(),
        _authData['password'].toString(),
      ).then((value) {if(value==true) {
        Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
      }
      });
    } on HttpException catch (error) {
      var errorMessage = 'فشل الاتصال بالسيرفر';
      if (error.toString().contains('Unauthorised')) {
        errorMessage = 'خطأ في الايميل او كلمة المرور';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'فشل الاتصال بالشبكة الرجاء المحاولة مرة اخرى';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }
 bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              " الايميل ",
              style: TextStyle(
                  color: MyColors.textColor, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: '  الايميل',
                contentPadding: const EdgeInsets.all(8),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.textColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.textColor)),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'رقم الهاتف لا يمكن ان يكون فارغا !';
                }
                return null;
              },
              onSaved: (value) {
                _authData['email'] = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "كلمة المرور ",
              style: TextStyle(
                  color: MyColors.textColor, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: MyColors.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                hintText: ' كلمة المرور',
                contentPadding: const EdgeInsets.all(8),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.textColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.textColor)),
              ),
              obscureText: _isObscure,
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'كلمة المرور قصيرة !';
                }
                return null;
              },
              onSaved: (value) {
                _authData['password'] = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                  Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);},
              child: const Text(
                "نسيت كلمة السر ؟",
                style: TextStyle(
                    fontSize: 16,
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            if (_isLoading)
             const Center(child:  CircularProgressIndicator(color: MyColors.primaryColor,))
            else
              MaterialButton(
                minWidth: double.infinity,
                color: MyColors.primaryColor,
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                padding: const EdgeInsets.all(6),
                textColor: MyColors.backgraoundColor,
                onPressed:  _submit
              ),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "  ليس لديك حساب ؟",
                style: TextStyle(
                    fontSize: 16,
                    color: MyColors.textColor,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(SignupScreen.routeName);
                },
                child: const Text(
                  "  انشاء حساب",
                  style: TextStyle(
                      fontSize: 16,
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

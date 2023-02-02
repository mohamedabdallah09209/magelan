
import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/models/http_exception.dart';
import 'package:magelan/providers/auth.dart';
import 'package:magelan/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup-screen';

  const SignupScreen({Key? key}) : super(key: key);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  
  
  bool ischecked = true;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:  const Text(
                        "انشاء حساب",
                        style: TextStyle(
                          color: MyColors.textColor,
                        ),
                      ),
                      centerTitle: true,
          backgroundColor: MyColors.backgraoundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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
                      // ignore: prefer_const_constructors
                     
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 30,
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
    'name': '',
    'email': '',
    'password': '',
    'phone': '',
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
      
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['name'].toString(),
          _authData['email'].toString(),
          _authData['phone'].toString(),
          _authData['password'].toString(),
        ).then((value) {if(value==true) {
        Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
      }
      });
     
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;
    return    SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               const Text(
                                " البريد الالكتروني",
                                style: TextStyle(
                                    color: MyColors.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: ' البريد الالكتروني',
                          contentPadding: const EdgeInsets.all(8),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: MyColors.textColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColors.textColor) ),
                        ),
                      
                      
                  
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'الايميل غير صحيح !';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
            
                const SizedBox(height: 10,),
               const Text(
                                "  الاسم الكامل",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: MyColors.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: ' الاسم الكامل ',
                          contentPadding: const EdgeInsets.all(8),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: MyColors.textColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColors.textColor) ),
                        ),
                        
                      
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الاسم مطلوب';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['name'] = value!;
                  },
                ),
                const SizedBox(height: 10,),
                
                 const Text(
              " رقم الهاتف",
              style: TextStyle(
                  color: MyColors.textColor, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: ' رقم الهاتف',
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
                _authData['phone'] = value!;
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
                hintText: ' كلمة المرور',
                contentPadding: const EdgeInsets.all(8),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.textColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.textColor)),
              ),
              obscureText: true,
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
              height: 15,
            ),
            
            if (_isLoading)
              const Center(child: CircularProgressIndicator(color: MyColors.primaryColor,))
            else
              MaterialButton(
                minWidth: double.infinity,
                color: MyColors.primaryColor,
                child: const Text(
                  'تسجيل ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                textColor: MyColors.backgraoundColor,
                onPressed: 
                  _submit
                
              ),
                      
              ],
            ),
          ),
        
      );
    
  }
}

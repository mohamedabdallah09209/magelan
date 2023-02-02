import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/screens/verfy_cod.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static const routeName = '/forgot';
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
   @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.backgraoundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: const Text(
                        "نسيت كلمة المرور ",
                        style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
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
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                             
                        const Text(
                                " ادخل رقم الهاتف او البريد الالكتروني",
                                style: TextStyle(
                                    color: MyColors.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'رقم الهاتف او البريد الالكتروني',
                          contentPadding: const EdgeInsets.all(8),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: MyColors.textColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColors.textColor) ),
                        ),
                        
                      ),
                     
                    
                      const SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        color: MyColors.primaryColor,
                        child: const Text(
                          'ارسال رمز الاسترجاع',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        textColor: MyColors.backgraoundColor,
                        onPressed: () {
                  Navigator.of(context).pushNamed(VerfyCodeScreen.routeName);
                        },
                      ),
                     
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

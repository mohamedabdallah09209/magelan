import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/screens/change_password.dart';

class VerfyCodeScreen extends StatefulWidget {
  const VerfyCodeScreen({Key? key}) : super(key: key);

  static const routeName = '/verfy';
  @override
  _VerfyCodeScreenState createState() => _VerfyCodeScreenState();
}

class _VerfyCodeScreenState extends State<VerfyCodeScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  bool visibility = false;

  @override
  void initState() {
    super.initState();

    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.backgraoundColor,
          elevation: 0,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
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
                        " ادخل الرمز المرسل",
                        style: TextStyle(
                            fontSize: 16,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Form(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: TextFormField(
                                    maxLength: 1,
                                    controller: _controller1,
                                    autofocus: true,
                                    obscureText: true,
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(2),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: MyColors.textColor),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.textColor)),
                                    ),
                                    onChanged: (value) {
                                      nextField(value, pin2FocusNode);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: TextFormField(
                                    maxLength: 1,
                                    controller: _controller2,
                                    focusNode: pin2FocusNode,
                                    obscureText: true,
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(2),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: MyColors.textColor),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.textColor)),
                                    ),
                                    onChanged: (value) =>
                                        nextField(value, pin3FocusNode),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: TextFormField(
                                    maxLength: 1,
                                    controller: _controller3,
                                    focusNode: pin3FocusNode,
                                    obscureText: true,
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(2),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: MyColors.textColor),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.textColor)),
                                    ),
                                    onChanged: (value) =>
                                        nextField(value, pin4FocusNode),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: TextFormField(
                                    maxLength: 1,
                                    controller: _controller4,
                                    focusNode: pin4FocusNode,
                                    obscureText: true,
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(2),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: MyColors.textColor),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.textColor)),
                                    ),
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        pin4FocusNode.unfocus();
                                        setState(() {
                                          visibility = true;
                                        });
                                        // Then you need to check is the code is correct or not
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: TextFormField(
                                    maxLength: 1,
                                    controller: _controller4,
                                    focusNode: pin4FocusNode,
                                    obscureText: true,
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(2),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: MyColors.textColor),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.textColor)),
                                    ),
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        pin4FocusNode.unfocus();
                                        setState(() {
                                          visibility = true;
                                        });
                                        // Then you need to check is the code is correct or not
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            //SizedBox(height: SizeConfig.screenHeight * 0.15),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        color: MyColors.primaryColor,
                        child: const Text(
                          'تأكيد',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        textColor: MyColors.backgraoundColor,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ChangePasswordScreen.routeName);
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

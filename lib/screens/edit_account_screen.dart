import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/models/http_exception.dart';
import 'package:magelan/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAccountScreen extends StatefulWidget {
  static const routeName = '/edit-screen';

  const EditAccountScreen({Key? key}) : super(key: key);
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
 String? _userEmail;
 String? _phone;
  String? _name;
  String? _password;

  late TextEditingController _userEmailController;
  late TextEditingController _phoneController;
  late TextEditingController _nameController;
  late final TextEditingController _passwordController=TextEditingController();
  Future<void> userData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {}

    Map<String, dynamic> extractedUserData =
        jsonDecode(prefs.getString("userData").toString())
            as Map<String, dynamic>;
    setState(() {
      _userEmail = extractedUserData['userEmail'].toString();
      _phone = extractedUserData['phone'].toString();
      _name = extractedUserData['name'].toString();
      _password = extractedUserData['password'].toString();
      
    });

    _userEmailController = TextEditingController(text: _userEmail);
    _phoneController = TextEditingController(text: _phone);
    _nameController = TextEditingController(text: _name);
  }

  @override
  void initState() {
    userData();
    super.initState();
  }

  var _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
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
      ),
    );
  }

  bool _isObscure = true;

  final _currentPassword = TextEditingController();

  void _showDialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(builder: (context, setState) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                content: const Text("تغيير كلمة المرور"),
                actions: <Widget>[
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
                      hintText: ' كلمة المرور الحالية',
                      // ignore: prefer_const_constructors
                      hintStyle: TextStyle(fontSize: 12),
                      contentPadding: const EdgeInsets.all(8),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: MyColors.textColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.textColor)),
                    ),
                    obscureText: _isObscure,
                    controller: _currentPassword,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.all(6),
                    minWidth: double.infinity,
                    color: MyColors.primaryColor,
                    child: const Text(
                      'تأكيد',
                      style: TextStyle(color: MyColors.backgraoundColor),
                    ),
                    onPressed: () {
                      if (_currentPassword.text.isEmpty) {
                        Fluttertoast.showToast(msg: '  الحقل مطلوب   ');
                      } else if (_currentPassword.text != _password) {
                        _showErrorDialog("كلمة المرور الحالية خاطئة");
                      } else {
                        _submit();
                        Navigator.of(ctx).pop();
                        Fluttertoast.showToast(msg: '  تم تعديل الحساب   ');
                      }
                    },
                  )
                ],
              ),
            );
          });
        });
  }

  final _form = GlobalKey<FormState>();
  Future<void> _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_userEmailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false)
            .editProfile(_userEmailController.text,
                 _phoneController.text,
                 _passwordController.text.isEmpty?_password.toString():_passwordController.text,
                 _nameController.text)
            .then((value) {
          if (value == true) {
            Navigator.of(context).pop();
          }
        });
        // ignore: unused_catch_clause
      } on HttpException catch (error) {
        var errorMessage = 'فشل الاتصال بالسيرفر';
        _showErrorDialog(errorMessage);
      } catch (error) {
        if (error.toString().contains(
            "FormatException: Unexpected character (at character 1)")) {
          const errorMessage = 'الايميل مستخدم مسبقا !';
          _showErrorDialog(errorMessage);
        }
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "تعديل الحساب",
            style: TextStyle(
              color: MyColors.textColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: MyColors.backgraoundColor,
          elevation: 0,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
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
                      SingleChildScrollView(
                        child: Form(
                          key: _form,
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
                                controller: _userEmailController,
                                decoration: InputDecoration(
                                  hintText: ' البريد الالكتروني',
                                  contentPadding: const EdgeInsets.all(8),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: MyColors.textColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColors.textColor)),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'الايميل غير صحيح !';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                               const SizedBox(
                                height: 10,
                              ),const Text(
                                "  الاسم الكامل",
                                style: TextStyle(
                                    color: MyColors.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: ' الاسم الكامل ',
                                  contentPadding: const EdgeInsets.all(8),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: MyColors.textColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColors.textColor)),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' الاسم مطلوب  !';
                                  }
                                   
                                  if (value.length<4) {
                                    return ' الاسم لا يمكن ان يكون اقل من 4 احرف  !';
                                  }
                                  return null;
                                },
                              ),
                              const Text(
                                " رقم الهاتف",
                                style: TextStyle(
                                    color: MyColors.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 70,
                                child: IntlPhoneField(
                                  initialValue: _phoneController.text
                                      .replaceFirst("0", ""),
                                  textAlign: TextAlign.right,
                                  countryCodeTextColor: MyColors.primaryColor,
                                  initialCountryCode: "SD",
                                  decoration: const InputDecoration(
                                    labelText: 'رقم الهاتف ',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  onChanged: (phone) {
                                    setState(() {
                                      _phoneController.text =
                                          "0${phone.number.toString()}";
                                    });
                                  },
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {
                                    setState(() {
                                      _phoneController.text =
                                          "0${value!.number.toString()}";
                                    });
                                  },
                                ),
                              ),
                             
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: ' كلمة المرور الجديدة',
                                        // ignore: prefer_const_constructors
                                        hintStyle: TextStyle(fontSize: 12),
                                        contentPadding: const EdgeInsets.all(8),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: MyColors.textColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: MyColors.textColor)),
                                      ),
                                      obscureText: true,
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value!.isNotEmpty &&
                                            value.length < 5) {
                                          return 'Password is too short!';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: ' اعادة كلمة المرور الجديدة',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        contentPadding: const EdgeInsets.all(8),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: MyColors.textColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: MyColors.textColor)),
                                      ),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value != _passwordController.text) {
                                          return 'كلمتا المرور غير متطابقتان !';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                ' في حال عدم الرغبة لتغيير كلمة المرور اترك الحقول فارغة ',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (_isLoading)
                                const Center(
                                    child: CircularProgressIndicator(
                                  color: MyColors.primaryColor,
                                ))
                              else
                                MaterialButton(
                                  minWidth: double.infinity,
                                  color: MyColors.primaryColor,
                                  child: const Text(
                                    'حفظ التغييرات ',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  textColor: MyColors.backgraoundColor,
                                  onPressed: () {
                                    _showDialog();
                                  },
                                ),
                            ],
                          ),
                        ),
                      )
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

 /* String? _userEmail;
  String? _phone;
  String? _name;
  String? _password;

  late TextEditingController _userEmailController;
  late TextEditingController _phoneController;
  late TextEditingController _nameController;
  late final TextEditingController _passwordController=TextEditingController();
  Future<void> userData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {}

    Map<String, dynamic> extractedUserData =
        jsonDecode(prefs.getString("userData").toString())
            as Map<String, dynamic>;
    setState(() {
      _userEmail = extractedUserData['userEmail'].toString();
      _phone = extractedUserData['phone'].toString();
      _name = extractedUserData['name'].toString();
      _password = extractedUserData['password'].toString();
      
    });

    _userEmailController = TextEditingController(text: _userEmail);
    _phoneController = TextEditingController(text: _phone);
    _nameController = TextEditingController(text: _name);
  }

  @override
  void initState() {
    userData();
    super.initState();
  }

  var _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child:  AlertDialog(
          title: const Text('حدث خطأ !'),
          content: Text(message),
          actions: <Widget>[
            MaterialButton(
              child:const Text('تم'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (
        _userEmailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      try {

        await Provider.of<Auth>(context, listen: false)
            .editProfile(_userEmailController.text,
                 _phoneController.text,
                 _passwordController.text.isEmpty?_password.toString():_passwordController.text,
                 _nameController.text)
            .then((value) {
          if (value == true) {
            Navigator.of(context).pop();
          }
        });
        // ignore: unused_catch_clause
      } on HttpException catch (error) {
        var errorMessage = 'فشل الاتصال بالسيرفر';
        _showErrorDialog(errorMessage);
      } catch (error) {
        if (error.toString().contains(
            "FormatException: Unexpected character (at character 1)")) {
          const errorMessage = 'الايميل مستخدم مسبقا !';
          _showErrorDialog(errorMessage);
        }
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "تعديل الحساب",
            style: TextStyle(
              color: MyColors.textColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: MyColors.backgraoundColor,
          elevation: 0,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
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
                      SingleChildScrollView(
                        child: Form(
                          autovalidateMode: AutovalidateMode.always, child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                " البريد الالكتروني",
                                style: TextStyle(
                                    color: MyColors.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: _userEmailController,
                                decoration: InputDecoration(
                                  hintText: ' البريد الالكتروني',
                                  contentPadding: const EdgeInsets.all(8),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: MyColors.textColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColors.textColor)),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 10,
                              ),const Text(
                                "  الاسم الكامل",
                                style: TextStyle(
                                    color: MyColors.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: ' الاسم الكامل ',
                                  contentPadding: const EdgeInsets.all(8),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: MyColors.textColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColors.textColor)),
                                ),
                                keyboardType: TextInputType.text,
                                
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                " رقم الهاتف",
                                style: TextStyle(
                                    color: MyColors.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  hintText: ' رقم الهاتف',
                                  contentPadding: const EdgeInsets.all(8),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: MyColors.textColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColors.textColor)),
                                ),
                                keyboardType: TextInputType.number,
                                
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "تغيير كلمة المرور ",
                                style: TextStyle(
                                    color: MyColors.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: ' كلمة المرور الجديدة',
                                        // ignore: prefer_const_constructors
                                        hintStyle: TextStyle(fontSize: 12),
                                        contentPadding: const EdgeInsets.all(8),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: MyColors.textColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: MyColors.textColor)),
                                      ),
                                      obscureText: true,
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value!.isNotEmpty &&
                                            value.length < 5) {
                                          return 'Password is too short!';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: ' اعادة كلمة المرور الجديدة',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        contentPadding: const EdgeInsets.all(8),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: MyColors.textColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: MyColors.textColor)),
                                      ),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value != _passwordController.text) {
                                          return 'كلمتا المرور غير متطابقتان !';
                                        }
                                        return null;
                                      },
                                      
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                ' في حال عدم الرغبة لتغيير كلمة المرور اترك الحقول فارغة ',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (_isLoading)
                                const CircularProgressIndicator()
                              else
                                MaterialButton(
                                  minWidth: double.infinity,
                                  color: MyColors.primaryColor,
                                  child: const Text(
                                    'حفظ التغييرات ',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  textColor: MyColors.backgraoundColor,
                                  onPressed: () {
                                    _submit();
                                  },
                                ),
                            ],
                          ),
                        ),
                      )
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
}*/

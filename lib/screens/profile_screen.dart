// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:  AppBar(
      backgroundColor: MyColors.backgraoundColor,
      elevation: 0.0,
      title: const Text(' الملف الشخصي'),
      centerTitle: true,
     
    ),
        body: SingleChildScrollView(
      
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  child: Container(
                    height: 150,
                    color: MyColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
         const Center(
          child: Text(" بروفايلي"),
        ),
        ],
      ),
    ),
      ),
    );
  }
}

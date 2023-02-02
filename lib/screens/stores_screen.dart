import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/providers/categories.dart';
import 'package:magelan/providers/stores.dart';
import 'package:magelan/screens/store_preivew.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/store_item.dart';

class StoresScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  const StoresScreen({Key? key}) : super(key: key);

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  String? _token;

  Future<void> userData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      _token=null;
    }else{
Map<String, dynamic> extractedUserData =
        jsonDecode(prefs.getString("userData").toString())
            as Map<String, dynamic>;
    setState(() {
      _token = extractedUserData['token'].toString();
    });
    }
    
  }

  @override
  void initState() {
    super.initState();

    userData();
  }

  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context)!.settings.arguments as String;
    var category = Provider.of<Categories>(
      context,
      listen: false,
    ).findById(categoryId);

    var stores = Provider.of<Stores>(
      context,
      listen: false,
    ).findStoreById(categoryId);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
              height: 60, child: Image.asset("assets/images/logo.png")),
          centerTitle: true,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: MyColors.backgraoundColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: Text(
                " متاجر قسم  ${category.name} ",
                style:
                    const TextStyle(fontSize: 16, color: MyColors.primaryColor),
              ),
            ),
            Expanded(
              child:stores.isNotEmpty
                              ? GridView.builder(
                padding: const EdgeInsets.all(15.0),
                itemCount: stores.length,
                itemBuilder: (ctx, i) {
                  return Column(
                    children: [
                      StoreItem(
                        id: stores[i].id,
                        lable: stores[i].name,
                        description: stores[i].description,
                        imageUrl: stores[i].imageUrl,
                        address: stores[i].address,
                        userId: stores[i].userId,
                        categoryId: stores[i].category,
                        rating: stores[i].rates!.isNotEmpty?stores[i].rates!:[],
                        index: i,
                       
                      ),
                      GestureDetector(
                        onTap: () {
                          _token != null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StorePreview(
                                        list: stores, index: i),
                                  ),
                                )
                              : Fluttertoast.showToast(
                                  msg: '  عليك بتسجيل الدخول اولا ');
                        },
                        child: const Text(
                          "التقيمات والتعليقات",
                          style: TextStyle(
                            fontSize: 12,
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 4 / 6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ): const Center(
                                  child: Text("لا توجد متاجر ")),
            ),
          ],
        ),
      ),
    );
  }
}

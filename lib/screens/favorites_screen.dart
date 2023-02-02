import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/providers/products.dart';
import 'package:magelan/screens/login_screen.dart';
import 'package:magelan/widgets/fav_products_items.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = '/favorites-product';

  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var _isInit = true;

  var _isLoading = false;

  String? _token;

  Future<void> userData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {}

    Map<String, dynamic> extractedUserData =
        jsonDecode(prefs.getString("userData").toString())
            as Map<String, dynamic>;
    setState(() {
      _token = extractedUserData['token'].toString();
    });
  }

  @override
  void initState() {
    userData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducs().then((rr) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final products =
        Provider.of<Products>(context).favoriteProducts;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
              height: 60, child: Image.asset("assets/images/logo.png"),),
          centerTitle: true,
          backgroundColor: MyColors.backgraoundColor,
          leading: const Text(''),
          actions: const [
            Text(''),
          ],
        ),
        body: _token != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: const Text(
                      "المنتجات المفضلة ",
                      style:
                          TextStyle(fontSize: 16, color: MyColors.primaryColor),
                    ),
                  ),
                  _isLoading == false
                      ? Expanded(
                          child: products.isNotEmpty
                              ? GridView.builder(
                                  padding: const EdgeInsets.all(15.0),
                                  itemCount: products.length,
                                  itemBuilder: (ctx, i) => FavProductsItems(
                                    id: products[i].id.toString(),
                                  ),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 6 / 8,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                )
                              : const Center(
                                  child: Text("لا توجد منتجات مفضلة")),
                        )
                      : const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ),
                ],
              )
            : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("عليك بتسجيل الدخول اولا لعرض المنتجات المفضلة"),
                    const SizedBox(height: 20,),
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
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                    ),
                  ],
                ),
            ),
      ),
    );
  }
}

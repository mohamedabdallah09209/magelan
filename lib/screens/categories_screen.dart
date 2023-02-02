import 'dart:async';
import 'package:flutter/material.dart';
import 'package:magelan/models/category.dart';
import 'package:magelan/models/slide.dart';
import 'package:magelan/providers/categories.dart';
import 'package:magelan/providers/products.dart';
import 'package:magelan/providers/sliedes.dart';
import 'package:magelan/providers/stores.dart';
import 'package:magelan/screens/all_categories_screen.dart';
import 'package:magelan/screens/stores_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../conistants/my_colors.dart';
import 'package:provider/provider.dart';

import 'ad_detail_screen.dart';
import 'all_ads_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _isInit = true;
  var _isLoading = false;

  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage1 = 0;
  final PageController _pageController1 = PageController(initialPage: 0);

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 8), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_currentPage1 < 2) {
        _currentPage1++;
      } else {
        _currentPage1 = 0;
      }

      _pageController1.animateToPage(
        _currentPage1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _pageController1.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducs();
      Provider.of<Slieds>(context).fetchSliedes();
      Provider.of<Stores>(context).fetchStores();
      Provider.of<Slieds>(context).findSlides();
      Provider.of<Categories>(context).fetchCategories().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  _launchURL(String urll) async {
    String url = urll;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoresData = Provider.of<Categories?>(context);
    final categories = categoresData!.categories;
    final slideList = Provider.of<Slieds>(context).slideList;
    final normalSlideList = Provider.of<Slieds>(context).findNormalSlides();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            SizedBox(height: 60, child: Image.asset("assets/images/logo.png")),
        centerTitle: true,
        backgroundColor: MyColors.backgraoundColor,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 170,
                child: Stack(
                  children: <Widget>[
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap: () {
                            _launchURL(slideList[i].title);
                          },
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                child: Hero(
                                  tag: "tag",
                                  child: FadeInImage(
                                    height: 170,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    placeholder: const AssetImage(
                                        'assets/images/product-placeholder.png'),
                                    image: NetworkImage(
                                      slideList[i].imageUrl,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'التصنيفات ',
                      style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: MyColors.primaryColor,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AllCategoriesScreen.routeName);
                      },
                      child: Row(
                        children: [
                          const Text(
                            'عرض الكل',
                            style: TextStyle(
                                color: MyColors.backgraoundColor, fontSize: 12),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: MyColors.backgraoundColor,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _isLoading == false
                  ? categories.isNotEmpty
                      ? MoreSell(
                          list: categories,
                        )
                      : const Center(child: Text("لا توجد اقسام "))
                  : const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'اعلانات ',
                      style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: MyColors.primaryColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(AllAdsScreen.routeName);
                      },
                      child: Row(
                        children: [
                          const Text(
                            'عرض الكل',
                            style: TextStyle(
                                color: MyColors.backgraoundColor, fontSize: 12),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: MyColors.backgraoundColor,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _isLoading == false
                  ? normalSlideList.isNotEmpty
                      ? MoreAds(
                          list: normalSlideList,
                        )
                      : const Center(child: Text("لا توجد اعلانات "))
                  : const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class MoreSell extends StatelessWidget {
  final List<Category> list;

  // ignore: use_key_in_widget_constructors
  const MoreSell({required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // ignore: unnecessary_null_comparison
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                StoresScreen.routeName,
                arguments: list[index].id,
              );
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              width: 120,
              decoration: BoxDecoration(
                color: MyColors.backgraoundColor,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 1,
                    color: MyColors.textColor,
                    spreadRadius: 0.1,
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ClipRRect(
                      // ignore: prefer_const_constructors
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(5),
                        topRight: const Radius.circular(5),
                      ),
                      // ignore: unnecessary_null_comparison
                      child: Hero(
                        tag: list[index].id,
                        child: FadeInImage(
                          placeholder: const AssetImage(
                              'assets/images/product-placeholder.png'),
                          image: NetworkImage(
                            list[index].imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    width: 160,
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          list[index].name,
                          style: const TextStyle(
                            color: MyColors.textColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MoreAds extends StatelessWidget {
  final List<Slide> list;

  // ignore: use_key_in_widget_constructors
  const MoreAds({required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // ignore: unnecessary_null_comparison
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AdDetailScreen.routeName,
                arguments: list[index].id,
              );
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              width: 120,
              decoration: BoxDecoration(
                color: MyColors.backgraoundColor,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 1,
                    color: MyColors.textColor,
                    spreadRadius: 0.1,
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ClipRRect(
                      // ignore: prefer_const_constructors
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(5),
                        topRight: const Radius.circular(5),
                      ),
                      // ignore: unnecessary_null_comparison
                      child: Hero(
                        tag: list[index].id,
                        child: FadeInImage(
                          placeholder: const AssetImage(
                              'assets/images/product-placeholder.png'),
                          image: NetworkImage(
                            list[index].imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    width: 160,
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "اعلان رقم : " + (index + 1).toString(),
                            style: const TextStyle(
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

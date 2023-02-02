import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import './favorites_screen.dart';
import './categories_screen.dart';
import 'account_screen.dart';
import 'search_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

 static const routeName = '/tabs';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> _pages;
   int _selectedPageIndex=0;
@override
  void didChangeDependencies() {
    final productId = ModalRoute.of(context)!.settings.arguments!=null? ModalRoute.of(context)!.settings.arguments as int:0;
    if(productId!=0){
      _selectedPageIndex=productId;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': const SearchScreen(),
        'title': 'Search',
      },
      {
        'page': const FavoritesScreen(),
        'title': 'Your Favorite',
      },
      {
        'page': const AccountScreen(),
        'title': 'Your Account',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          unselectedItemColor: MyColors.textColor,
          iconSize: 25,
          // ignore: deprecated_member_use
          selectedItemColor: MyColors.secondaryColor,
          showUnselectedLabels: true,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.fixed,
          items: const[
            // ignore: prefer_const_constructors
            BottomNavigationBarItem(
              backgroundColor: MyColors.backgraoundColor,
              icon:  Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              backgroundColor: MyColors.backgraoundColor,
              icon:  Icon(Icons.search),
              label: 'البحث',
            ),
            BottomNavigationBarItem(
              backgroundColor: MyColors.backgraoundColor,
              icon:  Icon(Icons.favorite),
              label: 'المفضلة',
            ),
            BottomNavigationBarItem(
              backgroundColor: MyColors.backgraoundColor,
              icon:  Icon(Icons.person_outline),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }
}

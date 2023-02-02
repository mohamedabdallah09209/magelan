import 'dart:io';
import 'package:flutter/material.dart';
import 'package:magelan/providers/auth.dart';
import 'package:magelan/providers/categories.dart';
import 'package:magelan/providers/products.dart';
import 'package:magelan/providers/sliedes.dart';
import 'package:magelan/providers/stores.dart';
import 'package:magelan/screens/about.dart';
import 'package:magelan/screens/account_screen.dart';
import 'package:magelan/screens/ad_detail_screen.dart';
import 'package:magelan/screens/all_ads_screen.dart';
import 'package:magelan/screens/all_categories_screen.dart';
import 'package:magelan/screens/change_password.dart';
import 'package:magelan/screens/edit_account_screen.dart';
import 'package:magelan/screens/favorites_screen.dart';
import 'package:magelan/screens/forgot_password.dart';
import 'package:magelan/screens/login_screen.dart';
import 'package:magelan/screens/products_screen.dart';
import 'package:magelan/screens/search_screen.dart';
import 'package:magelan/screens/signup_screen.dart';
import 'package:magelan/screens/use.dart';
import 'package:magelan/screens/verfy_cod.dart';
import './screens/tabs_screen.dart';
import 'screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'screens/stores_screen.dart';
import './screens/categories_screen.dart';
 class MyHttpOverrides extends HttpOverrides{
  @override


  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  
  HttpOverrides.global = MyHttpOverrides();
 runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => Categories(),
        ),
         ChangeNotifierProvider(
          create: (_) => Stores(),
        ),
        ChangeNotifierProvider(
          create: (_) => Slieds(),
        ),
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'magelan',
          theme: ThemeData(
            fontFamily: 'Cairo',
          ),
          debugShowCheckedModeBanner: false,
          home: const TabsScreen(),
           routes: {
            TabsScreen.routeName: (ctx) => const TabsScreen(),
             AllAdsScreen.routeName: (ctx) => const AllAdsScreen(),
            StoresScreen.routeName: (ctx) => const StoresScreen(),
            AllCategoriesScreen.routeName: (ctx) => const AllCategoriesScreen(),
            ProductsScreen.routeName: (ctx) => const ProductsScreen(),
            ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
            AdDetailScreen.routeName: (ctx) => const AdDetailScreen(),
            SearchScreen.routeName: (ctx) => const SearchScreen(),
            FavoritesScreen.routeName: (ctx) => const FavoritesScreen(),
            AccountScreen.routeName: (ctx) => const AccountScreen(),
            SignupScreen.routeName: (ctx) => const SignupScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            AbouteScreen.routeName: (ctx) => const AbouteScreen(),
            UseScreen.routeName: (ctx) => const UseScreen(),
            VerfyCodeScreen.routeName: (ctx) => const VerfyCodeScreen(),
            ForgotPasswordScreen.routeName: (ctx) =>
                const ForgotPasswordScreen(),
            ChangePasswordScreen.routeName: (ctx) =>
                const ChangePasswordScreen(),
            EditAccountScreen.routeName: (ctx) => const EditAccountScreen(),
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (ctx) => const CategoriesScreen(),
            );
          },
        ),
      ),
    );
  }
}

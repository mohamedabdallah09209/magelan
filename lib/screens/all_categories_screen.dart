import 'package:flutter/material.dart';
import 'package:magelan/providers/categories.dart';
import '../conistants/my_colors.dart';
import 'package:provider/provider.dart';
import '../widgets/category_item.dart';

class AllCategoriesScreen extends StatefulWidget {
  static const routeName = '/all-cat-screen';
  const AllCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final categoresData = Provider.of<Categories?>(context);
    final categories = categoresData!.categories;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:
              SizedBox(height: 60, child: Image.asset("assets/images/logo.png")),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          backgroundColor: MyColors.backgraoundColor,
        ),
        body: 
            ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, i) {
                return ChangeNotifierProvider.value(
                  value: categories[i],
                  child: const CategoryItem(),
                );
              },
            ),
          
      ),
    );
  }
}

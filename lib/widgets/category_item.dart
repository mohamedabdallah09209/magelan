import 'package:flutter/material.dart';
import 'package:magelan/models/category.dart';
import '../screens/stores_screen.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final category = Provider.of<Category>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          StoresScreen.routeName,
          arguments: category.id,
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: ClipRRect(
                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(5),
                          topRight: const Radius.circular(5),
                        ),
                        // ignore: unnecessary_null_comparison
                        child: Hero(
                  tag: category.id,
                  child: FadeInImage(
                    placeholder: const AssetImage(
                        'assets/images/product-placeholder.png'),
                    image: NetworkImage(
                      category.imageUrl,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: Container(
                        width: 300,
                        //color: Colors.black54,
                        // ignore: prefer_const_constructors
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 20,
                        ),
                        child: Text(
                          category.name,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

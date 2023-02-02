import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/models/product.dart';
import 'package:magelan/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/product_detail_screen.dart';

// ignore: must_be_immutable
class ProductsItems extends StatefulWidget {
  final String id;

  const ProductsItems(
      {Key? key,
      required this.id,
    })
      : super(key: key);

  @override
  State<ProductsItems> createState() => _ProductsItemsState();
}

class _ProductsItemsState extends State<ProductsItems> {
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
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context).findProductById(widget.id);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: widget.id,
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ClipRRect(
                
                // ignore: prefer_const_constructors
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(5),
                  topRight: const Radius.circular(5),
                ),
                child: Hero(
                  
                  tag: widget.id,
                  // ignore: unnecessary_null_comparison
                  child: products.imageUrl != null
                        ?FadeInImage(
                          height: 80,
                    width: double.infinity,
                    placeholder: const AssetImage(
                        'assets/images/product-placeholder.png'),
                    image: NetworkImage(
                      products.imageUrl.toString()
                    ),
                    fit: BoxFit.fill,
                  ): Image.asset(
                            'assets/images/category.jpg',
                            fit: BoxFit.fill,
                          ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      products.name.toString(),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                _token!=null?SizedBox(
                  child: ChangeNotifierProvider(
                    create: (context) => Product(
                        id: products.id,
                        store: products.store,
                        storeName: products.storeName,
                        storeNumber: products.storeNumber,
                        imageUrl: products.imageUrl,
                        name: products.name,
                        price: products.price,
                        description: products.description,
                        discountPrice: products.discountPrice,
                        isFavorite: products.isFavorite),
                    child: Consumer<Product>(
                      builder: (ctx, product, _) => IconButton(
                        icon: Icon(
                          product.isFavorite==true
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        color: MyColors.primaryColor,
                        onPressed: () {
                          product.toggleFavoriteStatus();
                          setState(() {
                          });
                        },
                      ),
                    ),
                  ),
                ):const Text(""),
              
              ],
            ),
            Container(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  products.description.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      const TextStyle(fontSize: 11, color: MyColors.textColor),
                )),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(right: 5, bottom: 5),
              child: Text(
                products.price.toString() + "  جنيه",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.secondaryColor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

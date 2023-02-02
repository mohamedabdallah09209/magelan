import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/models/product.dart';
import 'package:magelan/providers/products.dart';
import 'package:magelan/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';

// ignore: must_be_immutable
class FavProductsItems extends StatefulWidget {
  final String id;

  const FavProductsItems({Key? key,required this.id}) : super(key: key);
  

  @override
  State<FavProductsItems> createState() => _FavProductsItemsState();
}

class _FavProductsItemsState extends State<FavProductsItems> {

  @override
  Widget build(BuildContext context) {
    var favProducts = Provider.of<Products>(context).findProductById(widget.id);
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
          children: [ ClipRRect(
            
                // ignore: prefer_const_constructors
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(5),
                  topRight: const Radius.circular(5),
                ),
                child: Hero(
                  tag: widget.id,
                  child: FadeInImage(
                    height: 80,

                    width: double.infinity,
                    placeholder: const AssetImage(
                        'assets/images/product-placeholder.png'),
                    image: NetworkImage(
                      favProducts.imageUrl.toString(),
                    ),
                    fit: BoxFit.fill,
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
                      favProducts.name.toString(),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  child: ChangeNotifierProvider(
                    create: (context) => Product(
                        id: favProducts.id,
                        store: favProducts.store,
                         storeName: favProducts.storeName,
                        storeNumber: favProducts.storeNumber,
                        imageUrl: favProducts.imageUrl,
                        name: favProducts.name,
                        price: favProducts.price,
                        description: favProducts.description,
                        discountPrice: favProducts.discountPrice,
                        isFavorite: favProducts.isFavorite),
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
                           Navigator.of(context).pushReplacementNamed(TabsScreen.routeName,arguments: 2);
                        },
                      ),
                    ),
                  ),),
              ],
            ),
            Container(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  favProducts.description.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      const TextStyle(fontSize: 11, color: MyColors.textColor),
                )),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(right: 5, bottom: 5),
              child: Text(
                favProducts.price.toString() + "  جنيه",
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

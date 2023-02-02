import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findProductById(productId);
    return SafeArea(
      
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: MyColors.primaryColor,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: MyColors.backgraoundColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    selectedProduct.name.toString(),
                    style: const TextStyle(
                      color: MyColors.backgraoundColor,
                      fontSize: 20,
                    ),
                  ),
                  centerTitle: true,
                  background: Hero(
                    tag: selectedProduct.id.toString(),
                    child: FadeInImage(
                      placeholder: const AssetImage(
                          'assets/images/product-placeholder.png'),
                      image: NetworkImage(
                                  selectedProduct.imageUrl.toString(),
                                 
                                ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                              // ignore: prefer_const_constructors
                              Row(
                                children: [
                                  // ignore: prefer_const_constructors
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    // ignore: prefer_const_constructors
                                    child: Text(
                                      'اسم المنتج : ',
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: MyColors.primaryColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      selectedProduct.name.toString(),
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          // ignore: prefer_const_constructors
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // ignore: prefer_const_constructors
                            child: Text(
                              'وصف المنتج : ',
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontSize: 20, color: MyColors.primaryColor),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "         " + selectedProduct.description.toString(),
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                color: MyColors.textColor,
                              ),
                            ),
                          ),
                          Row(
                                children: [
                                  // ignore: prefer_const_constructors
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    // ignore: prefer_const_constructors
                                    child: Text(
                                      'اسم المتجر : ',
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: MyColors.primaryColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      selectedProduct.storeName.toString(),
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // ignore: prefer_const_constructors
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    // ignore: prefer_const_constructors
                                    child: Text(
                                      'رقم المورد : ',
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: MyColors.primaryColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      selectedProduct.storeNumber.toString(),
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          const SizedBox(height: 800),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 800,
                    ),
                  ],
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}

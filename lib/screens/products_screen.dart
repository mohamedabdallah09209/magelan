import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/providers/products.dart';
import 'package:magelan/providers/stores.dart';
import 'package:magelan/widgets/store_item.dart';
import 'package:provider/provider.dart';
import 'package:magelan/widgets/products_items.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = '/category-products';

  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

   var _isInit = true;

  // ignore: unused_field
  var _isLoading = false;

  
  @override
  void initState() {

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
    var storeId = ModalRoute.of(context)!.settings.arguments as Store;
    final products = Provider.of<Products>(
      context,listen: true
    ).findProductsByStoreId(storeId.id);
    final store = Provider.of<Stores>(
      context,listen: true
    ).findStore(storeId.id);

  
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(
            store.name??"اسم المتجر",
            style: const TextStyle(color: MyColors.primaryColor),
          ),
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
        body: products.isNotEmpty
                              ? GridView.builder(
          padding: const EdgeInsets.all(15.0),
          itemCount: products.length,
          itemBuilder: (ctx, i) => ProductsItems(
            id: products[i].id.toString(),
            
           
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 6 / 8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ): const Center(
                                  child: Text("لا توجد منتجات ")),
      ),
    );
  }
}

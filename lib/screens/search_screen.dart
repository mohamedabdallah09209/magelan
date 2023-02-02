// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/models/product.dart';
import 'package:magelan/providers/products.dart';
import 'package:magelan/widgets/products_items.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-product';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // ignore: prefer_final_fields
  TextEditingController _textEditingController = TextEditingController();
  late String value;
  var _isInit = true;
  var _isLoading = false;
  
  @override
  void initState() {
    super.initState();
  }

  List<Product> mainDataList = [];
  List<Product> newDataList = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      
          mainDataList = Provider.of<Products>(context, listen: true).products;
          newDataList = Provider.of<Products>(context, listen: true).products;
          _isLoading = false;
        
      
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  onItemChanged(value) async {
    setState(
      () {
        newDataList = mainDataList
            .where((element) => element.name.toString().toLowerCase().contains(value))
            .toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
              height: 60, child: Image.asset("assets/images/logo.png")),
          centerTitle: true,
          leading: const Text(''),
          actions: const [
            Text(''),
          ],
          backgroundColor: MyColors.backgraoundColor,
        ),
        backgroundColor: MyColors.backgraoundColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: MyColors.backgraoundColor,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    // ignore: prefer_const_constructors
                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 0.1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    
                    cursorColor: MyColors.primaryColor,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration.collapsed(
                      hintText: '  بحث عن منتج ...',
                    ),
                    controller: _textEditingController,
                    onChanged: onItemChanged,
                  ),
                ),
              ),
              Expanded(
                child: _isLoading == false
                    ? GridView.builder(
                        padding: const EdgeInsets.all(15.0),
                        itemCount: newDataList.length,
                        itemBuilder: (ctx, i) => ProductsItems(
                          id: newDataList[i].id.toString(),
                          
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
                        child: CircularProgressIndicator(
                        color: MyColors.primaryColor,
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

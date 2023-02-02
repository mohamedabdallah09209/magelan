
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/screens/products_screen.dart';

// ignore: must_be_immutable
class StoreItem extends StatefulWidget {
  String? id;
  String? lable;
  String? imageUrl;
  String? description;
  String? lng;
  String? lat;
  String? address;
  String? userId;
  String? categoryId;
  String? phone;
  List? rating;
   int? index;

  StoreItem({
    Key? key,
    this.id,
    this.lable,
    this.phone,
    this.imageUrl,
    this.index,
    this.description,
    this.lng,
    this.lat,
    this.address,
    this.userId,
    this.categoryId,
    this.rating,
  }) : super(key: key);

  @override
  State<StoreItem> createState() => _StoreItemState();
}

class _StoreItemState extends State<StoreItem> {

 double rating = 0.0;
  ratingNum() {
    if (widget.rating!.isNotEmpty) {
      rating = double.parse(widget.rating![0]["stars"].toString());
    } else {
      rating = 0.0;
    }
  }

  @override
  void initState() {
    super.initState();
    ratingNum();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductsScreen.routeName,
              arguments: Store(id: widget.id),
            );
          },
          child: Card(
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ClipRRect(
                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(5),
                          topRight: const Radius.circular(5),
                        ),
                        // ignore: unnecessary_null_comparison
                        child: widget.imageUrl!.contains("jpg")||widget.imageUrl!.contains("png")
                            ? Image.network(
                                widget.imageUrl.toString(),
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                'assets/images/category.jpg',
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    widget.address != null
                        ? Positioned(
                            left: 0,
                            child: ClipRRect(
                              // ignore: prefer_const_constructors
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(5),
                                bottomRight: const Radius.circular(5),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: MyColors.primaryColor,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  widget.address.toString()!="null"?widget.address.toString():"",
                                  style: const TextStyle(
                                    color: MyColors.backgraoundColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Text(""),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(right: 5),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          widget.lable.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.textColor,
                          ),
                        ),
                      ),
                      widget.description != "null"
                          ? Container(
                              padding: const EdgeInsets.only(right: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  widget.description.toString(),
                                  
                                  style: const TextStyle(
                                    color: MyColors.textColor,
                                    fontSize: 10,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          : const Text("لا يوجد وصف",
                                  style:  TextStyle(
                                    color: MyColors.textColor,
                                    fontSize: 10,
                                  ),),
                      Container(
                        alignment: Alignment.center,
                        // ignore: missing_required_param
                        child: RatingBar.builder(
                          initialRating: rating,
                          minRating: rating,
                          maxRating: rating,
                          tapOnlyMode: true,
                          itemSize: 15,
                          glowColor: MyColors.primaryColor,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: MyColors.secondaryColor,
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                      ),
                    ],
                  ),
                ),
               const SizedBox(height: 10,)
              ],
            ),
          ),
        ),
        
      ],
    );
  }
}

class Store {
  // ignore: prefer_typing_uninitialized_variables
  final id;
  // ignore: prefer_typing_uninitialized_variables
  final lable;
  Store({
    this.id,
    this.lable,
  });
}

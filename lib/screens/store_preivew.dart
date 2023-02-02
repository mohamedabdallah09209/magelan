import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/models/store.dart';
import 'package:magelan/screens/add_store_preview.dart';

class StorePreview extends StatefulWidget {
  final List<Store>  list;
  final int index;

   const StorePreview({Key? key, required this.list, required this.index}) : super(key: key);

  @override
  _StorePreviewState createState() => _StorePreviewState();
}

class _StorePreviewState extends State<StorePreview> {
  double rating = 0.0;
  ratingNum() {
    if (widget.list[widget.index].rates!.isNotEmpty) {
      rating = double.parse(widget.list[widget.index].rates![0]["stars"].toString());
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("التعليقات والتقييمات"),
          backgroundColor: MyColors.primaryColor,
          centerTitle: true,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: MyColors.backgraoundColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(
          children:  [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              // ignore: missing_required_param
              child: RatingBar.builder(
                initialRating: rating,
                minRating: rating,
                maxRating: rating,
                itemSize: 40,
                glowColor: MyColors.primaryColor,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding:const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>const Icon(
                  Icons.star,
                  color: MyColors.secondaryColor,
                ), onRatingUpdate: (double value) {  },
                //onRatingUpdate: (rating) {},
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                widget.list[widget.index].rates!.isNotEmpty? 
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 1.1,
                    child: ListView.builder(
                      itemCount: widget.list[widget.index].rates!.isNotEmpty?widget.list[widget.index].rates!.length:0,
                      itemBuilder: (context, i) {
                        return Container(
                          height: 80,
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: MyColors.textColor,
                                offset: Offset(0, 0),
                                spreadRadius: .1,
                                blurRadius: .1,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: double.infinity,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.list[widget.index].rates![i]
                                      ["comment"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: MyColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ):Container( padding:const EdgeInsets.all(20), child: const  Text('لا يوجد تعليقات')),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  padding:const EdgeInsets.symmetric(vertical: 6),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  color: MyColors.primaryColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProductPreview(
                            list: widget.list, index: widget.index),
                      ),
                    );
                  },
                  child: const Text(
                    "اضافة تقييم ",
                    style: TextStyle(
                      fontSize: 18,
                      color: MyColors.backgraoundColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/models/http_exception.dart';
import 'package:magelan/models/store.dart';
import 'package:magelan/providers/stores.dart';
import 'package:provider/provider.dart';

class AddProductPreview extends StatefulWidget {
  final List<Store> list;
  final int index;

   // ignore: use_key_in_widget_constructors
   const AddProductPreview({required this.list, required this.index});

  @override
  _AddProductPreviewState createState() => _AddProductPreviewState();
}

class _AddProductPreviewState extends State<AddProductPreview> {
  double rating = 0.0;
  final TextEditingController _nameController =  TextEditingController();
void _showProgress(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const[
                CircularProgressIndicator(),
                Text(
                  'الرجاء الانتظار',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        });
  }
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('حدث خطأ !'),
          content: Text(message),
          actions: <Widget>[
            MaterialButton(
              child: const Text('تم'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      ),
    );
  }
  _onPressed() async {
    if (rating != 0.0) {
      _showProgress(context);
      try {
        
      await Provider.of<Stores>(context, listen: false).estmate(
          _nameController.text,rating,widget.list[widget.index].id
        ).then((value) {if(value!=true) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: " لم يضاف التقييم ",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER);
        } else {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "تم اضافة التقييم",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER);
        }
      });
      // ignore: unused_catch_clause
      } on HttpException catch (error) {
      var errorMessage = 'فشل الاتصال بالسيرفر';
          _showErrorDialog(errorMessage);
      }
    } else {}
    
  }

  // ignore: unused_element
  

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title:const Text(" اضافة تقييم "),
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
          body:  ListView(
            children: <Widget>[
              Container(
                padding:const EdgeInsets.all(16),
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
                  ), onRatingUpdate: (double value) { rating=value; },
                  //onRatingUpdate: (rating) {},
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  maxLines: 5,
                  cursorColor: MyColors.primaryColor,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: '   التعليق ...    ',
                    hintStyle:  TextStyle(color: Colors.blueGrey),
                    contentPadding: EdgeInsets.all(3),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors.textColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors.primaryColor,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                  ),
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
                      _onPressed();
                    },
                    child: const Text(
                      "ارسال ",
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
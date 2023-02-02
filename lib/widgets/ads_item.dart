import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/models/slide.dart';
import 'package:magelan/screens/ad_detail_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AdsItem extends StatelessWidget {
   int? index;

   AdsItem({Key? key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ad = Provider.of<Slide>(context, listen: false);
    return InkWell(
      onTap: () {
         Navigator.of(context).pushNamed(
              AdDetailScreen.routeName,
              arguments: ad.id,
            );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: <Widget>[
            Column(
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
                    child: ad.imageUrl.contains("jpg") ||
                            ad.imageUrl.contains("png")
                        ? Image.network(
                            ad.imageUrl.toString(),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/category.jpg',
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                // ignore: unnecessary_null_comparison

                Container(
                  decoration: const BoxDecoration(
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "اعلان رقم : "+(index!+1).toString(),
                    style: const TextStyle(
                      color: MyColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

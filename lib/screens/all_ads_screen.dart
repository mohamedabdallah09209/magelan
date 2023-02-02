import 'package:flutter/material.dart';
import 'package:magelan/providers/sliedes.dart';
import 'package:magelan/widgets/ads_item.dart';
import '../conistants/my_colors.dart';
import 'package:provider/provider.dart';

class AllAdsScreen extends StatefulWidget {
  static const routeName = '/all-ads-screen';
  const AllAdsScreen({Key? key}) : super(key: key);

  @override
  State<AllAdsScreen> createState() => _AllAdsScreenState();
}

class _AllAdsScreenState extends State<AllAdsScreen> {
  @override
  Widget build(BuildContext context) {
    final adsData = Provider.of<Slieds?>(context);
    final ads = adsData!.slideList;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
              height: 60, child: Image.asset("assets/images/logo.png")),
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
        body: GridView.builder(
          padding: const EdgeInsets.all(15.0),
          itemCount: ads.length,
          itemBuilder: (ctx, i) {
            return ChangeNotifierProvider.value(
                  value: ads[i],
                  child:  AdsItem(index: i,),
                );
          },
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 7 / 6,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}

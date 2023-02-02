import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:magelan/providers/sliedes.dart';
import 'package:provider/provider.dart';

class AdDetailScreen extends StatelessWidget {
  static const routeName = '/ad-detail';

  const AdDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedAd = Provider.of<Slieds>(
      context,
      listen: false,
    ).findSlideById(adId);
    return Directionality(
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
                title: const Text(
                  "تفاصيل الاعلان",
                  style:  TextStyle(
                    color: MyColors.backgraoundColor,
                    fontSize: 20,
                  ),
                ),
                centerTitle: true,
                background: Hero(
                  tag: selectedAd.id.toString(),
                  child: FadeInImage(
                    placeholder: const AssetImage(
                        'assets/images/product-placeholder.png'),
                    image: NetworkImage(
                      selectedAd.imageUrl.toString(),
                    ),
                    fit: BoxFit.cover,
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

                        // ignore: prefer_const_constructors
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          // ignore: prefer_const_constructors
                          child: Text(
                            'وصف الاعلان  : ',
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                fontSize: 20, color: MyColors.primaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            selectedAd.description.toString(),
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        // ignore: prefer_const_constructors
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
    );
  }
}

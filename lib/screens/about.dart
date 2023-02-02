import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:magelan/conistants/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AbouteScreen extends StatelessWidget {
  static const routeName = '/aboute';
  const AbouteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          foregroundColor: MyColors.primaryColor,
          title: const Text(" عن التطبيق"),
          backgroundColor: MyColors.backgraoundColor,
          centerTitle: true,
        ),
        backgroundColor: MyColors.backgraoundColor,
        body: SafeArea(
            child: Container(
                //padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                alignment: Alignment.center,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.95,
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: MyColors.backgraoundColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        // SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        Container(
                          //decoration: BoxDecoration(color: ColorTest, shape: BoxShape.circle),
                          alignment: Alignment.topCenter,
                          height: MediaQuery.of(context).size.height * .20,
                          // padding: EdgeInsets.all(20),
                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration:
                              const BoxDecoration(shape: BoxShape.rectangle),
                          height: MediaQuery.of(context).size.height * .40,
                          child: const SingleChildScrollView(
                            child: Text(
                              "تطبيق ماجلان هو تطبيق الكتروني يعرض المتاجر والمنتجات بأحدث وافضل الطرق العصرية ويمكنك ايضا من الوصول فئة عريضة من العملاء المستهدفين باختصار هو عبارة عن منصة اعلانية ذات  نفوذ واسع",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MyColors.primaryColor,
                                  fontFamily: 'Fairuz-Bold',
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Padding(
                          padding:
                              EdgeInsets.only(right: 40, left: 40, bottom: 5),
                          child: Divider(
                            color: MyColors.primaryColor,
                            thickness: 2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          alignment: Alignment.centerRight,
                          child: const Text(
                            "تم تصمميه وتطويره بواسطة",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColors.primaryColor,
                                fontFamily: 'Fairuz-Bold',
                                fontSize: 12),
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                //padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Column(
                                  textDirection: TextDirection.ltr,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await launch(
                                            "https://www.facebook.com/NeverSDIT/");
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        textDirection: TextDirection.ltr,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0, right: 10),
                                            child: Icon(
                                              FontAwesomeIcons.facebookF,
                                              color: MyColors.primaryColor,
                                              size: 12,
                                            ),
                                          ),
                                          Text(
                                            "NeverSDIT",
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: MyColors.primaryColor,
                                                fontFamily: 'Product'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await launch('tel:+249115207094');
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        textDirection: TextDirection.ltr,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, right: 8),
                                            child: Icon(
                                              FontAwesomeIcons.phone,
                                              color: MyColors.primaryColor,
                                              size: 12,
                                            ),
                                          ),
                                          Text(
                                            "  249115207094+",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: MyColors.primaryColor,
                                                fontFamily: 'Product'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                // padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await launch(
                                            "https://www.linkedin.com/company/nsd-nevershutdown");
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        textDirection: TextDirection.ltr,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, right: 8),
                                            child: Icon(
                                                FontAwesomeIcons.linkedin,
                                                color: MyColors.primaryColor,
                                                size: 12),
                                          ),
                                          Text(
                                            "NSDIT",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: MyColors.primaryColor,
                                                fontFamily: 'Product'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await launch(
                                            "https://www.instagram.com/invites/contact/?i=1fz6ato5jdq93&utm_content=gtwr8u8");
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        textDirection: TextDirection.ltr,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, right: 8),
                                            child: Icon(
                                                FontAwesomeIcons.instagram,
                                                color: MyColors.primaryColor,
                                                size: 12),
                                          ),
                                          Text(
                                            "neversdit",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: MyColors.primaryColor,
                                                fontFamily: 'Product'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await launch(
                                      "https://www.instagram.com/invites/contact/?i=1fz6ato5jdq93&utm_content=gtwr8u8");
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: MyColors.primaryColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),

                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyColors.primaryColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: MyColors.primaryColor,
                                    ),
                                    alignment: Alignment.center,
                                    height:
                                        MediaQuery.of(context).size.width * .2,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    // padding: EdgeInsets.all(20),
                                    child: Image.asset(
                                      "assets/icons/NSD.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}

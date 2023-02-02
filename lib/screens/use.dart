import 'package:flutter/material.dart';
import 'package:magelan/conistants/my_colors.dart';

class UseScreen extends StatelessWidget {
  static const routeName = '/use';
  const UseScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: MyColors.primaryColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            elevation: 0,
            foregroundColor: MyColors.primaryColor,
            title: const Text(" سياسة الخصوصية والاستخدام  "),
            backgroundColor: MyColors.backgraoundColor,
            centerTitle: true,
          ),
          backgroundColor: MyColors.backgraoundColor,
          body: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:const [
                       SizedBox(
                        height: 10,
                      ),
                      
                      // SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      Text(
                        "سياسة الاستخدام :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 18),
                      ),
                       Text(
                       "1- نتفهم ان المستخدم يحمي نفسه من التعرض للاحتيال ",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                       Text(
                     "2- نتفهم ان المستخدم لديه المعرفة الكاملة انها منصة اعلان ليس الا وما لنا اي مسؤولية تجاه الاحتيال ",
                      
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                       Text(
                        "3- نحن اكثر طمئنة ان المستخدم لا يقوم بنشر اي جملة او صورة تخل بالاخلاق بشكل ما ومن يفعل يلاحق قانونيا , لذلك يمنع نشر اي اسلوب او صورة او فيديو مخل بالاخلاق .",
                      
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                       SizedBox(
                        height: 10,
                      ),
                       SizedBox(height: 5),
                         Padding(
                          padding:
                              EdgeInsets.only(right: 10, left: 10, bottom: 5),
                          child: Divider(
                            color: MyColors.primaryColor,
                            thickness: 2,
                          ),
                        ),
                      // SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      Text(
                        "سياسة الخصوصية :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 18),
                      ),
                      Text(
                       "ما هي البيانات التي يمكن ان نجمعها منك ؟",
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 16),
                      ),

                      Text(
                        "1- رقم الهاتف",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                       Text(
                     "2- البريد الالكتروني",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                       Text(
                        "3- الاسم",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                       Text(
                        "4- صورة المستخدم",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                       Text(
                        "5- اسم المتجر",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                       Text(
                       "6- اسماء المنتجات التي سيتم اضافتها في المتجر",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                      SizedBox(height: 10,),
                      Text(
                       "كيف نستخدم البيانات الخاصة بك ؟",
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 16),
                      ),

                      Text(
                        "يتم الاحتفاظ بالبيانات في غاية السرية بما يخدم البرنامج فقط ويتم الافصاح عن المعلومة في حالة الابتزاز والاحتيال او التميز العرقي والديني الى الجهات المختصة .",
                       //textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                      SizedBox(height: 10,),
                      Text(
                       "الى من يمكننا الافصاح عن البيانات ؟",
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 16),
                      ),

                      Text(
                       "1- المظلوم الذي تم ابتزازة",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                      Text(
                       "2- المحتال عليه",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                      Text(
                        "3- المتنمر عليه سواء كان دينيا او عرقيا او شكليا ",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                      Text(
                       "ملحوظة : لا يتم الافصاح عن هذه المعلومات الا الى الجهة الرسمية النيابة مثلا",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 17),
                      ),

                       SizedBox(height: 10,),
                      Text(
                       "كيف تخزن البيانات الخاصة بك ؟",
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 16),
                      ),

                      Text("يتم تخزين البيانات بطريقة تخزين البيانات داخل قاعدة البيانات العلائقية ومحركات قوائد البيانات  باستخدام لغة الاستعلام المهيكلة sql .",
                      //textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),

                      SizedBox(height: 10,),
                      Text(
                       "ما هي معايير الحماية التي يتم تطبيقها ؟",
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 16),
                      ),

                      Text(
                        "1- نقوم بتوفير اتصالات امنة من التطبيق الى الخوادم الخاصة بنا",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                       Text(
                     "2- نستخدم احدث اساليب الحماية لتخزين البيانات داخل خوادمنا",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                       Text(
                        "3- نستعين بفريق يقوم باكتشاف الثغرات الامنية وترقيعها بشكل دوري ومستمر .",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: 'Fairuz-Bold',
                            fontSize: 15),
                      ),
                      
                      SizedBox(height: 20,)
                    ]),
              ),
            ),
          )),
    );
  }
}

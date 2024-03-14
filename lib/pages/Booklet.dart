import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cell_explosion/classes/lesson.dart';
import 'package:cell_explosion/widgets/LessonCardTemplate.dart';
import 'package:cell_explosion/pages/Settings.dart';
import 'package:cell_explosion/classes/Themes.dart';
import 'package:cell_explosion/classes/clsApp.dart';
import '../widgets/ads/AppOpenAds.dart';
import '../widgets/ads/BannerAds.dart';
import '../widgets/ads/InterstitialAds.dart';

class Booklet extends StatefulWidget {
  const Booklet({super.key});
  @override
  State<Booklet> createState() => _BookletState();
}

class _BookletState extends State<Booklet>{


  bool bannerAdsLoaded = false;
  Widget bannerAds = BannerAds();
  int adClickCount = 0;

  List<Lesson> lesson = [];
  String appMode = 'trial';

  void loadThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultColorThemes;
      appMode = prefs.getString('appMode') ??  clsApp.DEFAULT_APP_MODE;
      adClickCount = prefs.getInt('adClickCount') ??  0;

      lesson = [
        Lesson(lessonNo: '0',title: 'PASIUNA',subTitle: 'Introduction',color: colorTheme),
        Lesson(lessonNo: '1',title: 'PATUKURANAN',subTitle: 'The Rock',color: colorTheme),
        Lesson(lessonNo: '2',title: 'KINABUHI HUMAN SA KAMATAYON',subTitle: 'Life After Death',color: colorTheme),
        Lesson(lessonNo: '3',title: 'KALUWASAN',subTitle: 'Salvation',color: colorTheme),
        Lesson(lessonNo: '4',title: 'USA LANG KA DALAN',subTitle: 'One Way',color: colorTheme),
        Lesson(lessonNo: '5',title: 'PAGKATAWO PAG-USAB',subTitle: 'New Life',color: colorTheme),
        Lesson(lessonNo: '6',title: 'TULO KA ASPETO SA KALUWASAN',subTitle: '3 Aspects of Salvation',color: colorTheme),
        Lesson(lessonNo: '7',title: 'MGA PANGUTANA MAHITUNGOD SA KALUWASAN',subTitle: 'Asking Of Salvation',color: colorTheme),
        Lesson(lessonNo: '8',title: 'KALUWASAN MAWALA BA O DILI NA',subTitle: 'Can Salvation Be Rebuke Or Not?',color: colorTheme),
        Lesson(lessonNo: '9',title: 'ANG PLANO SA DIOS',subTitle: 'Plan Of God',color: colorTheme),
        Lesson(lessonNo: '10',title: 'PAGLAKAW UBAN SA DIOS',subTitle: 'Witness',color: colorTheme),
        Lesson(lessonNo: '11',title: 'PITO KA TIMAILHAN',subTitle: 'Seven Signs',color: colorTheme),
        Lesson(lessonNo: '12',title: 'PAGKAGINOO',subTitle: 'Lordship',color: colorTheme),
      ];
    });
  }
  void updateAdClickCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('adClickCount', adClickCount);
  }

  @override
  void initState() {
    // TODO: implement initState
    loadThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
            child: Column(
              children:[

              Column(
                children: lesson.map((e) => LessonCardTemplate(
                    lesson: e,
                    appMode: appMode,
                    openLesson: (){
                      setState(() {
                        print(e.lessonNo);
                        if(appMode=='trial'){

                          InterstitialAds.load();

                          if(e.lessonNo=='1' || e.lessonNo=='2' || e.lessonNo=='3' || e.lessonNo=='4' || e.lessonNo=='5'){
                            Navigator.pushNamed(
                                context, '/lesson_details',arguments: {
                              'lessonNo' : e.lessonNo,
                              'title': e.title
                            });
                          }else{
                            showDialog(
                                context: context,
                                builder: (context)=> AlertDialog(
                                  title: const Text('Sorry, the app is a trial version. To unlock this, you need to buy the full version of this app.',style: TextStyle(fontSize: 16.0),),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: ()=>Navigator.pop(context,false),
                                        child:  Text('Ok',style: TextStyle(color: myThemes.getColor(colorTheme)),)),
                                  ],
                                )
                            );
                          }
                        }else{

                          //InterstitialAds.load();
                          //RewardedInterstitialAds.loadAd();
                          setState(() {

                            adClickCount++;
                            if(adClickCount>2){
                              adClickCount=0;
                              AppOpenAds.loadAd();
                            }
                            updateAdClickCount();
                            print('adCount=' + adClickCount.toString());

                            Navigator.pushNamed(
                                context, '/lesson_details',arguments: {
                              'lessonNo' : e.lessonNo,
                              'title': e.title
                            });
                          });

                        }


                      });
                    }
                )).toList(),
              ),

              ],

        ),
    ),
          ),
          BannerAds()])
    );

  }
}
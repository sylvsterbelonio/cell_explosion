
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cell_explosion/pages/FontSettings.dart';
import 'package:cell_explosion/pages/SplashScreen.dart';
import 'package:cell_explosion/pages/MainPage.dart';
import 'package:cell_explosion/pages/LessonDetails.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/home': (context) => const MainPage(),
            '/lesson_details': (context) => const LessonDetails(),
            '/font_settings': (context) => const FontSettings(),
          }
      ));
}







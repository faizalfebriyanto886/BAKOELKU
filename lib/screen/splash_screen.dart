import 'package:bakoelku/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SplashScreenView(
        navigateRoute: const Home(),
        duration: 4000,
        imageSize: 200,
        imageSrc: 'assets/icon/logo-bakoelku.png',
      ),
    );
  }
}
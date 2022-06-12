import 'package:bakoelku/screen/login/login.dart';
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
        navigateRoute: const LoginPage(),
        duration: 4000,
        imageSize: 200,
        imageSrc: 'assets/images/logo_bakoelku.png',
      ),
    );
  }
}
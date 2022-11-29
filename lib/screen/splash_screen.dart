import 'package:bakoelku/screen/main_page/view/main_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class Splash extends StatelessWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return SplashScreenView(
            navigateRoute: const MainPageView(),
            duration: 4000,
            imageSize: 200,
            imageSrc: 'assets/images/logo_bakoelku.png',
          );
        }
      ),
    );
  }
}

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bakoelku/screen/home_page.dart';
import 'package:bakoelku/screen/login/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else if (snapshot.hasError) {
            return SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: "Ooops!", 
                message: "Email dan password anda tidak cocok", 
                contentType: ContentType.warning
              )
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}

import 'package:bakoelku/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/lottie/128424-green-delivery-guy.json"),
        const SizedBox(height: 20),
        Text("Mohon Menunggu", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primary),)
      ],
    );
  }
}
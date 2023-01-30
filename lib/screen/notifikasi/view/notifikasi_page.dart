import 'package:bakoelku/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Notifikasi", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black)
        ),
      ),
      body: ListView.separated(
        itemCount: 12,
        padding: const EdgeInsets.all(15),
        separatorBuilder: (context, index) => const SizedBox(height: 20,), 
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primary
                ),
                child: const Icon(Iconsax.notification_bing5, color: Colors.white,),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: "Lala",
                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: " sedang dalam perjalanan",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black)
                        )
                      ]
                    )
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Iconsax.clock, color: greyColor, size: 16,),
                      const SizedBox(width: 10),
                      Text("17 Agustus 1945", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: greyColor),)
                    ],
                  )
                ],
              )
            ],
          );
        }, 
      ),
    );
  }
}
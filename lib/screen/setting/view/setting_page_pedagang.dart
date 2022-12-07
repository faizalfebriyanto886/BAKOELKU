import 'package:bakoelku/colors.dart';
import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:bakoelku/reusable_widget/custom_text_field.dart';
import 'package:bakoelku/screen/setting/controller/setting_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_page/view/main_page_view.dart';

class SettingPagePedagang extends StatelessWidget {
  const SettingPagePedagang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Ubah Data", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
        leading: IconButton(
          onPressed: () {
            Get.back();  
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black)
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: controller.getSettings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: primary),
                            color: Colors.white
                          ),
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/foto-profile.png"),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                            const SizedBox(height: 5),
                            Text(data['email'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: primary)
                              ),
                              child: Text(data['alamat'], style: TextStyle(color: primary, fontSize: 12, fontWeight: FontWeight.w500),),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primary.withOpacity(0.15)
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primary),
                                color: Colors.white
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/icon/upload-image.png", height: 40, width: 40),
                                  Text(
                                    "Ubah Tampilan Utama", 
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: hintTextColor
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          CustomTextFieldSettingWidget(
                            colorsBorder: primary,
                            widthSized: Get.width, 
                            hintText: data['name'], 
                            prefixText: "Ubah Nama"
                          ),
                          const SizedBox(height: 15),
                          CustomTextFieldSettingWidget(
                            colorsBorder: primary, 
                            widthSized: Get.width, 
                            hintText: data['email'], 
                            prefixText: "Ubah Email"
                          ),
                          const SizedBox(height: 15),
                          CustomTextFieldSettingWidget(
                            colorsBorder: primary,
                            widthSized: Get.width, 
                            hintText: data['no_telp'].toString(), 
                            prefixText: "Ubah No Telp",
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primary
                              ),
                              child: const Text("Simpan", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Get.to(() => const MainPageView()); 
                      },
                      child: Container(
                        height: 40,
                        width: Get.width * 0.7,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: danger,
                        ),
                        child: const Text(
                          "Log Out", 
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 14, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const CustomLoadingIndicator();
        }
      ),
    );
  }
}
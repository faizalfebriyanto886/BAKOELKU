// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bakoelku/colors.dart';
import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:bakoelku/screen/main_page/view/main_page_view.dart';
import 'package:bakoelku/screen/setting/controller/setting_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../reusable_widget/custom_text_field.dart';

class SettingPageView extends StatelessWidget {
  const SettingPageView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ubah data",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14
          ),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 28,
          ),
          onPressed: () => Get.back(),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getSettings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              padding: EdgeInsets.all(10),
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
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['name'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                        const SizedBox(height: 5),
                        Text(controller.dataUser!.email.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),),
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
                SizedBox(height: 20,),
                // Card setting data
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primary.withOpacity(0.5)
                  ),
                  child: Center(
                    child: Column(
                      children: [
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
                          prefixText: "Ubah No Telp"
                        ),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Get.to(() => MainPageView());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: Get.width * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: danger
                            ),
                            child: Text(
                              "Log Out", 
                              style: TextStyle(
                                fontSize: 16, 
                                color: Colors.white, 
                                fontWeight: FontWeight.w600
                              )
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                )
              ],
            );
          } 
          return CustomLoadingIndicator();
        }
      )
    );
  }
}
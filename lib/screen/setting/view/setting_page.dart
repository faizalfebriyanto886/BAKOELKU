// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/main_page/view/main_page_view.dart';
import 'package:bakoelku/screen/setting/controller/setting_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primary
                  )
                ),
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/foto-profile.png'
                      ),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                )
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lala", 
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    controller.dataUser!.email.toString(), 
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primary,
                        width: 2
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Surabaya", 
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20,),
          // Card setting data
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: meGreen
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  TextField( // Textfield ubah Nama
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: buttonGreen),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: buttonGreen),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: buttonGreen),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,)
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,color: Colors.black)
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                      ),
                      hintText: "Lala",
                      
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFB3B1B1)
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          "Ubah Nama",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: textFieldGreen,
                            fontSize: 14
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField( // Textfield ubah Email
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: buttonGreen),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: buttonGreen),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: buttonGreen),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,)
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,color: Colors.black)
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                      ),
                      hintText: controller.dataUser!.email,
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFB3B1B1)
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          "Ubah Email",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: textFieldGreen,
                            fontSize: 14
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField( // Textfield ubah no telp
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: buttonGreen),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: buttonGreen),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: buttonGreen),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,)
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,color: Colors.black)
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                      ),
                      hintText: "08773727183",
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFB3B1B1)
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          "Ubah No Telp",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: textFieldGreen,
                            fontSize: 14
                          ),
                        ),
                      ),
                    ),
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
                  SizedBox(height: 20,),
                ],
              )
            ),
          )
        ],
      )
    );
  }
}
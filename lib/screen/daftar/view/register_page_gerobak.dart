
import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/daftar/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../reusable_widget/custom_text_field.dart';

class RegisterPageGerobak extends StatelessWidget {
  final controller = Get.put(RegisterController());
  RegisterPageGerobak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backdoor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 80),
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images/logo_bakoelku.png", height: 120,),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                )
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Registrasi",
                      style: TextStyle(
                        color: primary,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Padding( // text Field for username
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: CustomTextFieldWithState(
                            controller: controller.namaGerobakController,
                            color: primary, 
                            hintText: "Isi Nama Gerobak kamu disini...", 
                            prefix: Icon(Icons.shopping_cart, color: primary)
                          )
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  bottomSheetUploadImage(context);
                                },
                                child: Container(
                                  height: 55,
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  width: Get.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 2,
                                      color: primary
                                    ),
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/icon/upload-image.png', height: 25),
                                      const SizedBox(width: 15),
                                      Text(
                                        "Unggah Foto Gerobak",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  controller.uploadToStorage(controller.usernameController.text, controller.namaGerobakController.text, context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: primary
                                    )
                                  ),
                                  child: Icon(Icons.file_upload_outlined, color: primary,),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.selectTimeBuka(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: primary, width: 2),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Icon(Iconsax.clock, color: primary,),
                                  const SizedBox(width: 10),
                                  Text("Jam Buka", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primary),)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.selectTimeTutup(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: primary, width: 2),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Icon(Iconsax.clock, color: primary,),
                                  const SizedBox(width: 10),
                                  Text("Jam Tutup", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primary),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CustomTextFieldWithState(
                        controller: controller.namaMenuController,
                        color: primary, 
                        hintText: "Isi Nama Menu kamu disini...", 
                        prefix: Icon(Icons.shopping_cart, color: primary)
                      )
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CustomTextFieldWithState(
                        controller: controller.hargaMenuController,
                        color: primary, 
                        hintText: "Isi Harga Menu kamu disini...", 
                        prefix: Icon(Icons.shopping_cart, color: primary)
                      )
                    ),

                    const SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              width: Get.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: danger
                              ),
                              child: const Text(
                                "Kembali",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.registrasiUserPedagang(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              width: Get.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primary
                              ),
                              child: const Text(
                                "Daftar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bottomSheetUploadImage(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                // controller.uploadImageCamera();
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: primary
                ),
                child: const Text("Kamera", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                controller.uploadImageGallery(context);
                Get.back();
              },
              child: Container(
                height: 50,
                width: Get.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: primary
                ),
                child: const Text("Gallery", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
              ),
            ),
          ],
        ),
      )
    );
  }
}
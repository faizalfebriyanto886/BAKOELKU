import 'package:bakoelku/colors.dart';
import 'package:bakoelku/reusable_widget/custom_text_field.dart';
import 'package:bakoelku/screen/daftar/controller/register_controller.dart';
import 'package:bakoelku/screen/daftar/view/register_page_gerobak.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterPageView extends StatelessWidget {
  const RegisterPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Scaffold(
      backgroundColor: backdoor,
      body: Stack(
        children: [
           Container(
            padding: const EdgeInsets.only(top: 75),
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images/logo_bakoelku.png", height: 100,)
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
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
                    Text( // Title Login
                      "Registrasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(                    
                        color: primary,
                        fontSize: 26,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.roleController.value = 'pedagang';
                                  controller.validationRole.value = false;
                                  controller.update();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: controller.roleController.value == 'pedagang' ? primary : greyColor.withOpacity(0.5), 
                                      width: 2
                                    )
                                  ),
                                  child: Icon(Icons.shopping_cart, color: controller.roleController.value == 'pedagang' ? primary : greyColor.withOpacity(0.5)),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  controller.roleController.value = 'pembeli';
                                  controller.validationRole.value = true;
                                  controller.update();

                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(color: controller.roleController.value == 'pembeli' ? primary : greyColor.withOpacity(0.5), width: 2)
                                  ),
                                  child: Icon(Icons.person_sharp, color: controller.roleController.value == 'pembeli' ? primary : greyColor.withOpacity(0.5)),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding( // text Field for username
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: CustomTextFieldWithState(
                            controller: controller.usernameController,
                            color: primary, 
                            hintText: "Isi username kamu disini...", 
                            prefix: Icon(Icons.person, color: primary)
                          )
                        ),
                  
                        const SizedBox(height: 15),
                        Padding( // text Field for email
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: CustomTextFieldWithState(
                            controller: controller.emailController,
                            color: primary, 
                            hintText: "Isi email kamu disini...", 
                            prefix: Icon(Icons.email, color: primary)
                          )
                        ),
                  
                        const SizedBox(height: 15),
                        Padding( // text Field for password
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: CustomTextFieldWithState(
                            controller: controller.passwordController,
                            color: primary, 
                            hintText: "Isi password kamu disini...", 
                            prefix: Icon(Icons.password, color: primary)
                          )
                        ),
                  
                        const SizedBox(height: 15),
                        Padding( // text Field for no telp
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: CustomTextFieldWithState(
                            controller: controller.noTelpController, 
                            color: primary, 
                            hintText: "8123456789", 
                            textInputType: TextInputType.number,
                            textInputFormatter: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp(r'^0+'), //users can't type 0 at 1st position
                              ),
                            ],
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 13),
                              child: Text(
                                "+62",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: primary
                                ),
                              ),
                            ),
                            onchange: (value) {},
                          )
                        ),
                  
                        const SizedBox(height: 15),
                        Padding( // text Field for alamat
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: CustomTextFieldWithState(
                            controller: controller.alamatController, 
                            color: primary, 
                            hintText: "Isi alamat kamu disini...", 
                          )
                        ),
                      ],
                    ),
              
                    const SizedBox(height: 15),
                    Obx(
                      () => GestureDetector( // Button Login
                        onTap: () {
                          if (controller.validationRole.value == false) {
                            Get.to(() => RegisterPageGerobak());
                          } else {
                            controller.registrasiUserPembeli(context);
                          }
                          // print(controller.roleController.value);
                        },
                        child: Container(
                          width: Get.width * 0.8,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            controller.validationRole.value == false 
                            ? "Lanjut"
                            : "Daftar",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    ),                  
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
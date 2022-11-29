import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/daftar/controller/register_controller.dart';
import 'package:bakoelku/screen/home_page.dart';
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
            alignment: Alignment.center,
            height: 350,
            child: Image.asset("assets/images/logo_bakoelku.png", height: 150,)
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                )
              ),
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              child: ListView(
                padding: const EdgeInsets.all(20),
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
                  
                  const SizedBox(height: 40,),
                  Padding( // text Field for username
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: controller.usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,)
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: Colors.black)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: primary)
                        ),
                        hintText: "Isi username kamu disini...",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFB3B1B1)
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: primary,
                        )
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  Padding( // text Field for email
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,)
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: Colors.black)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: primary)
                        ),
                        hintText: "Isi email kamu disini...",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFB3B1B1)
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: primary,
                        )
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  Padding( // text Field for password
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,)
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: Colors.black)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: primary)
                        ),
                        hintText: "Isi password kamu disini...",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFB3B1B1)
                        ),
                        prefixIcon: Icon(
                          Icons.password_rounded,
                          color: primary,
                        )
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  Padding( // text Field for no telp
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: controller.noTelpController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]'),
                        ),
                        FilteringTextInputFormatter.deny(
                          RegExp(r'^0+'), //users can't type 0 at 1st position
                        ),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: primary),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,)
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: Colors.black)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: primary)
                        ),
                        hintText: "8123456789",
                        hintStyle: const TextStyle(
                          fontSize: 17,
                          color: Color(0xFFB3B1B1)
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 13),
                          child: Text(
                            "+62",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: primary
                            ),
                          ),
                        )
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  GestureDetector( // Button Login
                    onTap: () {
                      controller.registrasiUser(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Text(
                        "Daftar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
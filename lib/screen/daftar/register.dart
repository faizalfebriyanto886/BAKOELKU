import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/daftar/controller/register_controller.dart';
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
              padding: const EdgeInsets.all(20),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: primary, width: 2)
                          ),
                          child: Icon(Icons.shopping_cart, color: primary,),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: primary, width: 2)
                          ),
                          child: Icon(Icons.person_sharp, color: primary,),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Padding( // text Field for username
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,)
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,color: Colors.black)
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,color: Colors.yellowAccent)
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
              
                    const SizedBox(height: 15),
                    Padding( // text Field for email
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,)
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,color: Colors.black)
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,color: Colors.yellowAccent)
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
              
                    const SizedBox(height: 15),
                    Padding( // text Field for password
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,)
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,color: Colors.black)
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,color: Colors.yellowAccent)
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
              
                    const SizedBox(height: 15),
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
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,)
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,color: Colors.black)
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,color: Colors.yellowAccent)
                          ),
                          hintText: "81231425982",
                          hintStyle: const TextStyle(
                            fontSize: 14,
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
              
                    const SizedBox(height: 15),
                    Padding( // text Field for alamat
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        // controller: controller.noTelpController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,)
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,color: Colors.black)
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 2,color: Colors.yellowAccent)
                          ),
                          hintText: "isi alamat kamu disini...",
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFFB3B1B1)
                          ),
                        ),
                      ),
                    ),
              
                    const SizedBox(height: 15),
                    GestureDetector( // Button Login
                      onTap: () {
                        controller.registrasiUser(context);
                      },
                      child: Container(
                        width: Get.width * 0.8,
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
            ),
          )
        ],
      ),
    );
  }
}
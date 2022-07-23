import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPageView extends StatelessWidget {
  const RegisterPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: meGreen,
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
                      color: meGreen,
                      fontSize: 26,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  
                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: meGreen, 
                            width: 2,
                          ),
                        ),
                        hintText: "Isi username kamu disini...",
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: meGreen,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: meGreen, 
                            width: 2,
                          ),
                        ),
                        hintText: "Isi email kamu disini...",
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: meGreen,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: meGreen, 
                            width: 2,
                          ),
                        ),
                        hintText: "Isi password kamu disini...",
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.password_outlined,
                          color: meGreen,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      maxLength: 5,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: meGreen, 
                            width: 2,
                          ),
                        ),
                        hintText: "Isi alamat kamu disini...",
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  GestureDetector( // Button Login
                    onTap: () => Get.to(() => const Home()),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: meGreen,
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

  Widget fieldWidget(
    {
    required String hintText,
    required TextEditingController? controller,
    required IconData icon,
    }
  ){
    
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: meGreen, 
              width: 2,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.7),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: meGreen,
          ),
        ),
      ),
    );
  }
}
import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/daftar/register.dart';
import 'package:bakoelku/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(                    
                      color: meGreen,
                      fontSize: 26,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  
                  const SizedBox(height: 40,),
                  Padding( // text Field for email
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: buttonGreen),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: buttonGreen),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                        hintText: "Isi email kamu disini...",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFB3B1B1)
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: buttonGreen,
                        )
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  Padding( // text Field for password
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: buttonGreen),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: buttonGreen),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                        hintText: "Isi password kamu disini...",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFB3B1B1)
                        ),
                        prefixIcon: Icon(
                          Icons.password_outlined,
                          color: buttonGreen,
                        )
                      ),
                    ),
                  ),

                  const Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(         
                      onPressed: null, 
                      child: Text(
                        "Lupa Password?",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.normal
                        ),
                      )
                    ),
                  ),

                  GestureDetector( // Button Login
                    onTap: () => Get.to(() => const Home()),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0XFFA0A4FF),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      const Text(
                        "Belum memiliki akun?",
                        style: TextStyle(
                          color: Colors.grey,

                        ),
                      ),
                      TextButton(
                        onPressed: ()=> Get.to(()=> const RegisterPageView()), 
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                            color: buttonGreen
                          ),
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

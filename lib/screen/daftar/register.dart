import 'package:bakoelku/colors.dart';
import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.only(top: 330),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              decoration:  const BoxDecoration(
                color: Colors.white,
               borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text( // Title Register
                    "Datar dulu yaa!!!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(                    
                      color: meGreen,
                      fontSize: 26,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  fieldWidget(
                    hintText: "Isi Username kamu disini.....",
                    controller: null,
                    icon: Icons.people
                  ),
                  fieldWidget(
                    hintText: "Isi email kamu disini.....",
                    controller: null,
                    icon: Icons.mail
                  ),
                  fieldWidget(
                    hintText: "Isi password kamu disini.....",
                    controller: null,
                    icon: Icons.lock
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: SizedBox(
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding:const  EdgeInsets.all(40),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: meGreen, 
                              width: 2,
                            ),
                          ),
                          hintText: "Isi alamat kamu disini....",
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: meGreen,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector( // Button daftar
                    onTap:  null,
                    child: Container(
                      width: 300,
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
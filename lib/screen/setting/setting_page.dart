// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/splash_screen.dart';
import 'package:flutter/material.dart';

class SettingPageView extends StatelessWidget {
  const SettingPageView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah data",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        automaticallyImplyLeading: true,
        leading: Icon(
          Icons.chevron_left_sharp,
          color: Colors.black,
          size: 34,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 40),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: meGreen,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/face.jpg"),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  )
                ),
                SizedBox(width: 8,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lala",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    Text("Faizalfebriyanto@gmail.com",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Chip(
                        backgroundColor: Colors.white,
                        label: Text("Surabaya",
                        textAlign: TextAlign.center,
                          style: TextStyle(
                          color: meGreen,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: meGreen, width: 1),
                          borderRadius: BorderRadius.circular(40),
                        )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
              color: meGreen,
              borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  fieldWidget(
                    hintText: "Lala", 
                    controller: null, 
                    surfixName: "Ubah nama",
                  ),
                  fieldWidget(
                    hintText: "Lala", 
                    controller: null, 
                    surfixName: "Ubah nama",
                  ),
                  fieldWidget(
                    hintText: "Lala", 
                    controller: null, 
                    surfixName: "Ubah nama",
                  ),
                  GestureDetector( // Button Login
                    onTap: (){
                      Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                          Animation secondaryAnimation) {
                        return Splash();
                      }, transitionsBuilder: (BuildContext context, Animation<double> animation,
                          Animation<double> secondaryAnimation, Widget child) {
                        return  SlideTransition(
                          position:  Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      }),
                    (Route route) => false);
                    },
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Text(
                        "Log out",
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
    required String surfixName,
    }
  ){
    
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true, 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: meGreen,
              width: 2.0,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.7),
            fontSize: 20,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  surfixName,
                  style: TextStyle(
                  color: meGreen,
                  fontSize: 20,
                ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
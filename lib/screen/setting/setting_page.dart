// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bakoelku/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPageView extends StatelessWidget {
  const SettingPageView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          ListTile(
            contentPadding: EdgeInsets.all(5),
            leading: CircleAvatar(
              radius: 35.0,
              backgroundColor: Colors.amber,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text( // title setting username
                "Lala",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( // title setting Email
                  "Faizalfebriyanto886@gmail.com",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 8),
                Container( // chip kota
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            width: 1,
                            color: textFieldGreen
                        )
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Text(
                      "Surabaya",
                      style: TextStyle(
                        fontSize: 12,
                        color: textFieldGreen
                      )
                    ),
                  ),
                )
              ],
            ),
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
                      hintText: "Faizal@gmail.com",
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
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 15, right: 15))
                    ),
                    onPressed: null,
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    )
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
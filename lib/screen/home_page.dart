import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/setting/view/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildMaps(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 70),
                    child: GestureDetector(
                      onTap:()=>  Get.to(()=>const  SettingPageView()),
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primary),
                          color: Colors.white
                        ),
                        child: Icon(
                          Icons.settings,
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                  Expanded( // TextField mencari pedagang
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70, left: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(9),
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
                          hintText: "Mencari Pedagang kesukaanmu...",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFB3B1B1)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 70),
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primary),
                        color: Colors.white
                      ),
                      child: Icon(
                        Icons.search,
                        color: primary,
                      ),
                    ),
                  ),
                ],
              ),

              // for Detail menu
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/mart-dummy.png",
                        height: 75,
                      ),

                       ListTile(
                        title: const Text(
                          "Mie Ayam Solo",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: const Text(
                          "Kota Surabaya",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: primary,
                              radius: 16,
                              child: const Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              backgroundColor: primary,
                              radius: 16,
                              child: const Icon(
                                Icons.messenger,
                                color: Colors.white,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 13,),

                      Container( // Button for next
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: primary,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Menuju Lokasi",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: Colors.white,
                              size: 28,
                            )
                          ],
                        )
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ]
      ),
    );
  }
}

// widget maps
Widget buildMaps() {
  return GestureDetector(
    child: Column(
      children: <Widget>[
        Expanded(
          child: Image.asset(
            'assets/images/maps_screenshot.png',
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ))
      ],
    ),
  );
}
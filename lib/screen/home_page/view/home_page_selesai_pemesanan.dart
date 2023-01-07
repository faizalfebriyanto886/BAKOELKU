import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colors.dart';

class HomepageSelesaiPemesanan extends StatelessWidget {
  const HomepageSelesaiPemesanan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildMaps(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.to(() => const SettingPageView(), arguments: docId);
                      },
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
                    SizedBox(
                      width: Get.width * 0.65,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(9),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1, color: primary),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1, color: primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                    GestureDetector(
                      onTap: () {},
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
              ),

              // for Detail menu
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: primary)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/mart-dummy.png", height: 70,),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        minLines: 5,
                        maxLines: 7,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(9),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1, color: primary),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1, color: primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                          hintText: "Ketik Ulasan",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFB3B1B1)
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        child: Container(
                          height: 40,
                          width: Get.width * 0.7,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: primary,
                          ),
                          child: const Text(
                            "Selesai",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ),
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

  Widget buildMaps() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/maps_screenshot.png'),
          fit: BoxFit.cover
        )
      ),
    );
  }
}
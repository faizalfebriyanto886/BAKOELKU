import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/chat/view/chat_page.dart';
import 'package:bakoelku/screen/home_page/controller/home_controller.dart';
import 'package:bakoelku/screen/setting/view/setting_page_pembeli.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final String docId;
  const HomePage({ required this.docId, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: Stack(
        children: [
          buildMaps(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap:()=>  Get.to(()=> const SettingPageView(), arguments: docId),
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
                    Container(
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
                      CarouselSlider(
                        items: controller.imageCarousel.map((value) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: primary)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(value,),
                          )
                        )).toList(),
                        options: CarouselOptions(
                          height: 90,
                          aspectRatio: 16/9,
                          viewportFraction: 0.4,
                          initialPage: 0,
                          enlargeCenterPage: true,
                          autoPlay: false, // jika sudah maka autoplay bisa di aktifkan
                          autoPlayAnimationDuration: const Duration(seconds: 5),
                          autoPlayCurve: Curves.bounceIn,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Mie Ayam Solo",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Kota Surabaya",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),

                            CircleAvatar(
                              backgroundColor: primary,
                              radius: 18,
                              child: const Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () => Get.to(() => const ChatPageView()),
                              child: CircleAvatar(
                                backgroundColor: primary,
                                radius: 18,
                                child: const Icon(
                                  Icons.messenger,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
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
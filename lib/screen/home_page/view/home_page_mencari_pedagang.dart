import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/home_page/controller/home_controller.dart';
import 'package:bakoelku/screen/home_page/view/home_page_menuju_customer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../chat/view/chat_page.dart';
import '../../setting/view/setting_page_pembeli.dart';

class HomePageMencariPedagang extends StatelessWidget {
  final String docId;
  const HomePageMencariPedagang({
    required this.docId,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: Stack(
        children: [
          buildMaps(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 20),
                child: GestureDetector(
                  onTap:()=> Get.to(()=> const SettingPageView(), arguments: docId),
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
                              GestureDetector( // button Next
                                onTap: () => Get.to(() => HomePageMenujuCustomer(docId: docId)),
                                child: Container(
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
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector( // button cancel
                          onTap: () => Get.back(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: danger,
                              ),
                              child: Row(
                                children: const [
                                  Text(
                                    "Batalkan Rute",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              )
                            ),
                          ),
                          GestureDetector( // button Sampai Tujuan
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: second,
                              ),
                              child: Row(
                                children: const [
                                  Text(
                                    "Sampai Tujuan",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              )
                            ),
                          ),
                        ],
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
import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/history/controller/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HistoryPagePedagang extends StatelessWidget {
  const HistoryPagePedagang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Riwayat Pesanan", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black)
        ),
      ),
      body: GetBuilder<HistoryController>(
        init: controller.getDataOrderPedagang(),
        builder: (context) {
          return controller.getOrders.isNotEmpty 
          ? ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: controller.getOrders.length,
            separatorBuilder: (context, index) => const SizedBox(height: 15,), 
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(2, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.getOrders[index]['nama_pembeli'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Iconsax.location5, color: second, size: 16),
                                const SizedBox(width: 5),
                                Text(controller.getOrders[index]['alamat_pedagang'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: greyColor),)
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Iconsax.medal_star5, color: Colors.amber, size: 16),
                                const SizedBox(width: 5),
                                Text(controller.getOrders[index]['rate'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: greyColor),)
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text("Ulasan : ${controller.getOrders[index]['ulasan']}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),)
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: second
                        ),
                        child: Text(controller.getOrders[index]['status'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),),
                      )
                    ],
                  ),
                ),
              );
            }, 
          )
          : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/data-not-found.png', height: 250,),
                const SizedBox(height: 15),
                const Text("Data Tidak Ditemukan", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),)
              ],
            ),
          );
        }
      ),
    );
  }
}
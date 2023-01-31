import 'package:bakoelku/colors.dart';
import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:bakoelku/screen/notifikasi/controller/notifikasi_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotifikasiController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Notifikasi", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black)
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("notifikasi").orderBy('tanggal', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> dataNotif = snapshot.data!.docs;
            return ListView.builder(
              itemCount: dataNotif.length, 
              itemBuilder: (context, index) {
                Timestamp tanggalFirestore = dataNotif[index]['tanggal'];
                return GestureDetector(
                  onTap: () {
                    // print(dataNotif[index]['docId']);
                    controller.updateStatusRead(dataNotif[index]['docId']);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    color: dataNotif[index]['notifikasi_status'] == false ? greyColor.withOpacity(0.2) : Colors.white,
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primary
                          ),
                          child: const Icon(Iconsax.notification_bing5, color: Colors.white,),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: dataNotif[index]['nama_pembeli'],
                                style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                children: const [
                                  TextSpan(
                                    text: " sedang dalam perjalanan",
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black)
                                  )
                                ]
                              )
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Iconsax.clock, color: greyColor, size: 16,),
                                const SizedBox(width: 10),
                                Text(DateTime.parse(tanggalFirestore.toDate().toString()).toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: greyColor),)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }, 
            );
          }
          return const CustomLoadingIndicator();
        }
      ),
    );
  }
}
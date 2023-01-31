import 'package:bakoelku/colors.dart';
import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:bakoelku/screen/setting/controller/setting_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../reusable_widget/custom_text_field.dart';

class SettingPageMenuPedagang extends StatelessWidget {
  final controller = Get.put(SettingController());
  SettingPageMenuPedagang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Object?>>(
      stream: FirebaseFirestore.instance.collection("auth").doc(controller.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!.data() as Map<String, dynamic>;
          List menuList = data['menu'];
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text("Pengaturan Menu", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black)
              ),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  bottomSheetAddMenu(context);
                },
                child: Container(
                  height: 45,
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primary
                  ),
                  child: const Text("Tambah Menu", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      "List Menu",
                      style: TextStyle(
                        color: primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  ListView.separated(
                    itemCount: menuList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10,),
                    separatorBuilder: (context, index) => const SizedBox(height: 15,), 
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: const Key("Items"),
                        onDismissed: (direction) {},
                        confirmDismiss: (direction) {
                          return Alert(
                            context: context,
                            type: AlertType.warning,
                            title: "Konfirmasi penghapusan menu",
                            desc: "Apakah anda yakin menghapus menu ini ?",
                            buttons: [
                              DialogButton(
                                onPressed: () {
                                  controller.deleteMenuToFirestore(menuList[index]);
                                  Navigator.of(context).pop(true);
                                },
                                color: primary,
                                child: const Text(
                                  "Hapus",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                              DialogButton(
                                onPressed: () => Get.back(canPop: false),
                                color: danger,
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              )
                            ],
                          ).show();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primary)
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                                ),
                                child: Image.asset("assets/icon/icon_menu_2.png", height: 40,),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(menuList[index]['nama'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                                    const SizedBox(height: 8),
                                    Text("Rp.${menuList[index]['harga'].toString()}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: greyColor),)
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  bottomSheetUbahMenu();
                                  // controller.deleteMenuToFirestore(menuList[index]);
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Iconsax.edit_25, color: Colors.white, size: 18,),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },                
                  )
                ]
              )
            )
          );
        }
        return Container(
          color: Colors.white,
          child: const CustomLoadingIndicator());
      }
    );
  }

  bottomSheetUbahMenu() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.3,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primary),
            color: primary.withOpacity(0.2)
          ),
          child: Column(
            children: [
              CustomTextFieldSettingWidget(
                controller: controller.namaMenuUbahController,
                colorsBorder: primary,
                widthSized: Get.width, 
                hintText: "Pentol", 
                prefixText: "Nama Makanan"
              ),
              const SizedBox(height: 15),
              CustomTextFieldSettingWidget(
                controller: controller.hargaMenuUbahController,
                colorsBorder: primary,
                widthSized: Get.width, 
                hintText: "Rp.14000", 
                prefixText: "Harga Makanan"
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  controller.ubahMenuToFirestore();
                  Get.back();
                },
                child: Container(
                  height: 40,
                  width: Get.width * 0.7,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primary
                  ),
                  child: const Text(
                    "Ubah Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  bottomSheetAddMenu(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.3,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primary),
            color: primary.withOpacity(0.2)
          ),
          child: Column(
            children: [
              CustomTextFieldSettingWidget(
                controller: controller.namaMenuAddController,
                colorsBorder: primary,
                widthSized: Get.width, 
                hintText: "Pentol", 
                prefixText: "Nama Makanan"
              ),
              const SizedBox(height: 15),
              CustomTextFieldSettingWidget(
                controller: controller.hargaMenuAddController,
                colorsBorder: primary,
                widthSized: Get.width, 
                hintText: "Rp.14000", 
                prefixText: "Harga Makanan",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  controller.addMenuTofirestore(context);
                  Get.back();
                },
                child: Container(
                  height: 40,
                  width: Get.width * 0.7,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primary
                  ),
                  child: const Text(
                    "Tambahkan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
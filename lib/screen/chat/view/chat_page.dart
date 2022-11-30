import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPageView extends StatelessWidget {
  const ChatPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: const Text("Mie Ayam", style: TextStyle(fontSize: 18, color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          }, 
          icon: const Icon(Icons.arrow_back, color: Colors.white)
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              width: Get.width * 0.75,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: greyColor.withOpacity(0.2),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(width: 1, color: greyColor.withOpacity(0.2)),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(width: 1, color: greyColor.withOpacity(0.2)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(width: 1, color: greyColor.withOpacity(0.2)),
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
                  hintText: "Kirim Pesanmu...",
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: greyColor
                  ),
                ),
              )
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.send_rounded, color: primary, size: 30,),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: controller.chatList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: controller.chatList[index].role ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              controller.chatList[index].role
              ? Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  ),
                ),
                child: Text(controller.chatList[index].message, style: const TextStyle(color: Colors.white, fontSize: 14),),
              )
              : Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  ),
                ),
                child: Text(controller.chatList[index].message, style: const TextStyle(color: Colors.white, fontSize: 14),),
              ) 
            ],
          );
        },
      )
    );
  }
}
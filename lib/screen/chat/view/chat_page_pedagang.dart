import 'package:bakoelku/colors.dart';
import 'package:bakoelku/screen/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPagePedagangView extends StatelessWidget {
  const ChatPagePedagangView({Key? key}) : super(key: key);

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
      body: GetX<ChatController>(
        init: controller.getChat(),
        builder: (datamessage) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: controller.scrollController,
                  padding: const EdgeInsets.all(15),
                  itemCount: controller.chatPedagang.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return  Row(
                      mainAxisAlignment: controller.chatPedagang[index]['role'] == "pedagang" ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        controller.chatPedagang[index]['role'] == "pedagang"
                        ? Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                            )
                          ),
                          child: Text(controller.chatPedagang[index]['message'], style: const TextStyle(color: Colors.white, fontSize: 14),),
                        )
                        : Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                            )
                          ),
                          child: Text(controller.chatPedagang[index]['message'], style: const TextStyle(color: Colors.white, fontSize: 14),),
                        ) 
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: Get.width * 0.75,
                      child: TextField(
                        controller: controller.fieldMessage,
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
                      onTap: () {
                        controller.sentMessagePedagang(context);
                      },
                      child: Icon(Icons.send_rounded, color: primary, size: 30,),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      )
    );
  }
}
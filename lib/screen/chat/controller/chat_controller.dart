import 'package:bakoelku/reusable_widget/alert_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final collectionChat = FirebaseFirestore.instance.collection('chat');
  final fieldMessage = TextEditingController();
  final ScrollController scrollController = ScrollController();
  RxList chatPedagang = [].obs;

  var args = Get.arguments;

  getChat() {
    collectionChat.where('uid_pedagang', isEqualTo: args).get().then((value) {
      for (var element in value.docs) {
        collectionChat.doc(element.data()['docId']).collection("pesan").orderBy('waktu', descending: false).get().then((valueChat) {
          for (var elementChat in valueChat.docs) {
            chatPedagang.add(elementChat.data());
            update();
          }
        });
      }
    });
    update();
  }

  sentMessagePembeli(BuildContext context) {
    if (fieldMessage.text.isNotEmpty) {
      collectionChat.where('uid_pedagang').get().then((value) {
        for (var element in value.docs) {
          collectionChat.doc(element.data()['docId']).collection('pesan').add({
            'message': fieldMessage.text,
            'role': 'pembeli',
            'statusRead': false,
            'waktu': DateTime.now(),
          }).then((value) {
            fieldMessage.clear();
            chatPedagang.clear();
            getChat();
          });
          update();
        }
      });
      update();
    } else {
      CustomAlertDialogWarning(
        title: "Mohon Maaf", 
        subTitle: "Silahkan isi pesan kamu", 
        context: context
      );
    }
  }

  sentMessagePedagang(BuildContext context) {
    if (fieldMessage.text.isNotEmpty) {
      collectionChat.where('uid_pedagang').get().then((value) {
        for (var element in value.docs) {
          collectionChat.doc(element.data()['docId']).collection('pesan').add({
            'message': fieldMessage.text,
            'role': 'pedagang',
            'statusRead': false,
            'waktu': DateTime.now(),
          }).then((value) {
            fieldMessage.clear();
            chatPedagang.clear();
            getChat();
          });
          update();
        }
      });
      update();
    } else {
      CustomAlertDialogWarning(
        title: "Mohon Maaf", 
        subTitle: "Silahkan isi pesan kamu", 
        context: context
      );
    }
  }
}
import 'package:get/get.dart';

class ChatController extends GetxController {
  final roleCustomer = false.obs;

  List<ModelChat> chatList = [
    ModelChat(
      message: "Lokasi ?", 
      role: false, 
      name: "Customer", 
      date: "14-10-2022"
    ),
    ModelChat(
      message: "Manyar Boss..", 
      role: true, 
      name: "pedagang", 
      date: "14-10-2022"
    ),
  ];
}

class ModelChat {
  String message;
  bool role;
  String name;
  String date;

  ModelChat({
    required this.message,
    required this.role,
    required this.name, 
    required this.date,
  });
}
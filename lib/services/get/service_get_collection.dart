import 'package:bakoelku/model/auth_model.dart';
import 'package:bakoelku/reusable_widget/alert_widget.dart';
import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreServices {
  CollectionReference authServices = FirebaseFirestore.instance.collection('auth');

  getAuthServices(String documentId) {
    return FutureBuilder(
      future: authServices.doc(documentId).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          CustomAlertDialogWarning(
            title: "Oops", 
            subTitle: "Server sedang gangguan", 
            context: context
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          CustomAlertDialogWarning(
            title: "Oops", 
            subTitle: "Data sudah ada", 
            context: context
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          AuthModel authData = AuthModel(nama: data['name'], email: data['email'], alamat: data['alamat'], role: data['role'], noTelp: data['no_telp']);
          return Text('data');
        }

        return const CustomLoadingIndicator();
      },
    );
  }
}
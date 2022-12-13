import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendingMessageModel {
  submit(String message) async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection("chat").add({
      "text": message,
      "currentDate": Timestamp.now(),
      "userId": userData["id"],
      "userName": userData["name"],
    });
  }
}

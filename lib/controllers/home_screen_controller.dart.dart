import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class HomeScreenController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  Rx<UserModel?> user = Rx<UserModel?>(null);

  @override
  void onInit() async {
    super.onInit();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          user.value = UserModel.fromMap(userData);
        }
      }
    }
  }
}

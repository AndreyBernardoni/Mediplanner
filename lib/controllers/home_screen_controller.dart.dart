import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class HomeScreenController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Rx<UserModel?> user = Rx<UserModel?>(null);

  HomeScreenController() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      user = Rx<UserModel?>(UserModel(
          name: currentUser.displayName ?? "",
          email: currentUser.email ?? "",
          isOlderly: false));
    }
  }

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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplanner/repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final isOlderly = false.obs;

  void registerUser(
      String email, String password, String name, bool isOlderly) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password, name, isOlderly);
  }
}

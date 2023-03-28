// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediplanner/repository/exceptions/signup_email_password_failure.dart';

import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, (callback) => _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => HomeScreen());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name, bool isOlderly) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .set({
          'name': name,
          'email': email,
          'isOlderly': isOlderly,
        });
        Get.offAll(() => const LoginScreen());
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print(ex);
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print(ex);
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => HomeScreen());
    } on FirebaseAuthException catch (_) {
    } catch (_) {}
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(() => LoginScreen());
  }
}

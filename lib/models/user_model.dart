// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final bool isOlderly;
  final String uId;
  final String? pairedWithuId;
  final String pairCode;
  List? medications;

  UserModel({
    required this.name,
    required this.email,
    required this.isOlderly,
    required this.uId,
    this.pairedWithuId,
    required this.pairCode,
    this.medications,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      isOlderly: map['isOlderly'],
      uId: map['uId'],
      pairedWithuId: map['pairedWithuId'],
      pairCode: map['pairCode'],
      medications: map['medications'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'isOlderly': isOlderly,
      'uId': uId,
      'pairedWithuId': pairedWithuId,
      'pairCode': pairCode,
      'medications': medications,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  void deleteMedication(String medicationName) {
    try {
      medications!
          .removeWhere((medication) => medication['name'] == medicationName);
      FirebaseFirestore.instance.collection('users').doc(uId).update({
        'medications': medications,
      });

      ("Medication: $medicationName deleted");
    } catch (e) {
      print(e);
    }
  }
}

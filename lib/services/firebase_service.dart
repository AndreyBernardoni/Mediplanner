import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  FirebaseService._();
  static final instance = FirebaseService._();

  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  CollectionReference<Map<String, dynamic>> get medicationCollection {
    return FirebaseFirestore.instance.collection('medications');
  }

  Future<void> addMedication(Map<String, dynamic> data) async {
    await medicationCollection.add(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMedications() {
    return medicationCollection.snapshots();
  }
}

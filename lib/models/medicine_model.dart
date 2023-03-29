import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineModel {
  String name;
  int quantity;
  List<DateTime> times;
  DateTime startDate;
  DateTime endDate;
  String frequency;

  MedicineModel({
    required this.name,
    required this.quantity,
    required this.times,
    required this.startDate,
    required this.endDate,
    required this.frequency,
  });

  MedicineModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        quantity = json['quantity'],
        times = (json['times'] as List<dynamic>)
            .map((time) => DateTime.parse(time.toString()))
            .toList(),
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']),
        frequency = json['frequency'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'times': times.map((time) => time.toIso8601String()).toList(),
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'frequency': frequency,
      };

  MedicineModel copyWith({
    String? name,
    int? quantity,
    List<DateTime>? times,
    DateTime? startDate,
    DateTime? endDate,
    String? frequency,
  }) {
    return MedicineModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      times: times ?? this.times,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      frequency: frequency ?? this.frequency,
    );
  }
}

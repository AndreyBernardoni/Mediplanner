import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplanner/screens/home/home_screen.dart';
import '../../models/medicine_model.dart';
import '../../services/firebase_service.dart';

class AddMedicationScreen extends StatefulWidget {
  @override
  _AddMedicationScreenState createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _frequencyController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService.instance;

  List<String> _times = ['9:00 AM', '12:00 PM', '6:00 PM'];
  List<TextEditingController> _timeControllers = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _times.length; i++) {
      _timeControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _frequencyController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    for (var i = 0; i < _timeControllers.length; i++) {
      _timeControllers[i].dispose();
    }
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Create medicineModel object
      final medicineModel = MedicineModel(
        name: _nameController.text,
        quantity: int.parse(_quantityController.text),
        frequency: _frequencyController.text,
        startDate: DateTime.parse(_startDateController.text),
        endDate: DateTime.parse(_endDateController.text),
        times: _timeControllers
            .map((timeController) => DateTime.parse(timeController.text))
            .toList(),
      );

      // Save medicineModel object to Firebase Firestore
      await _firebaseService
          .addMedication(medicineModel as Map<String, dynamic>);

      // Navigate to home screen
      Get.offAll(() => HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add MedicineModel'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _frequencyController,
                decoration: InputDecoration(labelText: 'Frequency'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a frequency';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _startDateController,
                      decoration: InputDecoration(labelText: 'Start Date'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a start date';
                        }
                        if (DateTime.tryParse(value) == null) {
                          return 'Please enter a valid start date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _endDateController,
                      decoration: InputDecoration(labelText: 'End Date'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an end date';
                        }
                        if (DateTime.tryParse(value) == null) {
                          return 'Please enter a valid end date';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Times'),
              SizedBox(height: 16),
              for (var i = 0; i < _times.length; i++)
                Row(
                  children: [
                    Expanded(
                      child: Text(_times[i]),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _timeControllers[i],
                        decoration: InputDecoration(labelText: 'Time'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a time';
                          }
                          if (DateTime.tryParse(value) == null) {
                            return 'Please enter a valid time';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

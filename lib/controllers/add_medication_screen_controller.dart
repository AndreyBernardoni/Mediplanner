import 'package:get/get.dart';

class AddMedicationScreenController extends GetxController {
  RxString frequency = 'apenas alguns dias na semana'.obs;
  RxList<String> daysSelected = <String>[].obs;
  RxList<String> timesSelected = <String>[].obs;

  void setFrequency(String value) {
    frequency.value = value;
  }

  void toggleDay(String day) {
    if (daysSelected.contains(day)) {
      daysSelected.remove(day);
      print(daysSelected);
    } else {
      daysSelected.add(day);
      print(daysSelected);
    }
  }
}

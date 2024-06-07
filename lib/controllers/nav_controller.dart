import 'package:get/get.dart';

class NavController extends GetxController {
  final RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  void changeSelectedIndex(int index) {
    _selectedIndex.value = index;
  }
}

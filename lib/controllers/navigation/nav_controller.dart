import 'package:get/get.dart';

class NavController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changePageIndex(int index) {
    pageIndex.value = index;
  }
}

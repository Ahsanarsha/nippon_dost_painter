import 'package:get/get.dart';

class NavbarController extends GetxController {
  RxInt index = 0.obs;
  RxBool isSelected = false.obs;
  RxBool isBack = false.obs;

  void changeIndex(int newIndex) {
    index.value = newIndex;
  }

  void changeBar(bool value) {
    isSelected.value = value;
  }

  void goBack(bool value) {
    isBack.value = value;
  }
}

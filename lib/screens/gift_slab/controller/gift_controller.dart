import 'package:get/get.dart';

class GiftController extends GetxController {
  RxString giftName = ''.obs;
  int? _selectedIndex;

  dynamic get selectedIndex => _selectedIndex;

  void setIndex(int index){
    _selectedIndex = index;
  }

  void changeName(String name) {
    giftName.value = name;
  }
}
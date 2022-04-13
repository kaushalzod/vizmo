import 'package:get/get.dart';

class HomepageController extends GetxController {
  final _currentIndex = 0.obs;

  int get getCurrentIndex => _currentIndex.value;

  void setCurrentIndex(int value) {
    _currentIndex(value);
  }
}

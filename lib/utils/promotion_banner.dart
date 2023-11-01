import 'dart:math';

class LoadBanner {
  static bool bannerX() {
    int num = Random().nextInt(100);
    bool promotion = num / 2 != 0;
    return promotion;
  }
}
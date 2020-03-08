import 'package:flutter/cupertino.dart';

class ScrollHelper {
  static ScrollConfiguration noGlowScroll(SingleChildScrollView child) {
    return ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: child);
  }
}

class NoGlowScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

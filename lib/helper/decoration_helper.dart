import 'package:flutter/cupertino.dart';
import 'package:workoutapp/style/styles.dart';

class DecorationHelper {
  static BoxShadow boxShadowSubtle({Color color}) {
    if (color == null) {
      color = Styles.darkNeutral.withOpacity(0.3);
    }
    return BoxShadow(
                      color: color,
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                    );
  }

  static BorderRadius borderRadiusButton() {
    return BorderRadius.all(Radius.circular(24));
  }
}
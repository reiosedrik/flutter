import 'dart:core';

import 'package:workoutapp/helper/data_helper.dart';

class RepModel {
  int repCount;
  String displayWeight;
  double weight;

  RepModel(this.repCount, this.weight) {
    setDisplayWeight();
  }

  void removeWeight(double amount) {
    weight -= amount;
    setDisplayWeight();
  }

  void addWeight(double amount) {
    weight += amount;
    setDisplayWeight();
  }

  void setDisplayWeight() {
    this.displayWeight = DataHelper.removeTrailingZerosFromDecimal(weight);
  }
}

class DataHelper {

  static String removeTrailingZerosFromDecimal(double n) {
     var result = n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
     return result;
  }

}
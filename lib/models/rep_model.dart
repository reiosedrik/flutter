class RepModel {
  int repCount;
  double weight;

  RepModel(this.repCount, this.weight);

  static List<RepModel>  testList() {
    var result = new List<RepModel>();
    result.add(RepModel(6, 82.5));
    result.add(RepModel(6, 85));
    result.add(RepModel(6, 87.5));
    result.add(RepModel(6, 90));
    result.add(RepModel(6, 85));

    return result;
  }
}
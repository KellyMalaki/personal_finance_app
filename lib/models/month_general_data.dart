class MonthGeneralData{
  late String year;
  late String label;
  late String path;
  late int totalIncome;
  late int totalSpending;
  late int monthId;

  //Normal constructor
  /*UserModel(){
  };*/

  //From all data filled
  MonthGeneralData.allDataKnown(this.monthId, this.year, this.label, this.path, this.totalIncome, this.totalSpending);

  //Constructor from json
  //MonthGeneralData.getFromAPI({required String month, required String year, required String label, required income, required String spending}){
  MonthGeneralData.getFromAPI(Map<String, dynamic> month, List<dynamic> years){
    monthId = int.parse(month["_id"]);
    label = month["label"];
    path = month["path"];
    totalIncome = int.parse(month["income"]);
    totalSpending = int.parse(month["spendings"]);
    year = years.firstWhere((element) => element["_id"] == month["year"])["label"];
  }
}
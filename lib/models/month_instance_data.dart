class MonthInstanceModel{
  late String date;
  late String day;
  late bool type;
  late String label;
  late int amount;
  //Normal constructor
  /*UserModel(){
  };*/

  //From all data filled
  MonthInstanceModel.dataHandFilled(this.date, this.day, this.type, this.label, this.amount);

  //Constructor from json
  MonthInstanceModel.fromJsonMap(Map<String, dynamic> monthInstance, List<dynamic> days){
    date = monthInstance["date"];
    day = days.firstWhere((element) => element["_id"] == monthInstance["day"])["label"];
    type = (monthInstance["type"] == "0");
    label = monthInstance["label"];
    amount = int.parse(monthInstance["amount"]);
  }
}
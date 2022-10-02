import 'package:personal_finance_app/custom_widgets/all_static_widgets.dart';

import 'month_instance_data.dart';

class MonthListInstancesModel{
  late int monthId;
  late String monthName;
  late String year;
  late int spendings;
  late int income;
  List<MonthInstanceModel> theItems = [];
  /*UserModel(){
  };*/

  //From all data filled
  //MonthListInstancesModel.dataHandFilled(this.date, this.day, this.type, this.label, this.amount);

  //Constructor from json
  MonthListInstancesModel.fromJsonMap(List<dynamic> theJsonFile, int theId, List<dynamic> allDays, this.monthName, this.year, this.income, this.spendings){
    monthId = theId;
    theItems = theJsonFile.map((e) => MonthInstanceModel.fromJsonMap(e,allDays)).toList();
  }
}
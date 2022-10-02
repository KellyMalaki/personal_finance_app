import 'package:flutter/material.dart';
import 'package:personal_finance_app/models/month_list_instances.dart';
import '../../../custom_widgets/all_static_widgets.dart';
import '../../../models/month_general_data.dart';

class MonthList extends StatefulWidget {
  List<MonthGeneralData> allMonths;
  List<MonthListInstancesModel> loadedMonthData;
  Function monthFunction;
  MonthList({Key? key, required this.allMonths, required this.monthFunction, required this.loadedMonthData}) : super(key: key);

  @override
  State<MonthList> createState() => _MonthListState();
}

class _MonthListState extends State<MonthList> {
  final GlobalKey _listKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    //Create a list of all the months they display it
    List<Widget> monthsWidgets = [];
    for (var element in widget.allMonths) {
      monthsWidgets.add(eachMonth(element, context, widget.monthFunction, widget.loadedMonthData));
    }
    return monthListCardView(
      child: Column(
        children: [
        Expanded(
          child: ListView.separated(key: _listKey, itemCount: monthsWidgets.length, scrollDirection: Axis.vertical, shrinkWrap: true, itemBuilder: (context, index) {
            return monthsWidgets[index];
          }, separatorBuilder: (BuildContext context, int index) { return const Divider(); },
      ),
        )
    ]));
  }
}

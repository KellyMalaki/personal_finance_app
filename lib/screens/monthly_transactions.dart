import 'package:flutter/material.dart';
import 'package:personal_finance_app/custom_widgets/all_static_widgets.dart';
import 'package:personal_finance_app/models/month_list_instances.dart';
import 'package:personal_finance_app/screens/screen_layers/monthly_transactions/month_list.dart';

import '../models/month_general_data.dart';

class MonthlyTransactions extends StatefulWidget {
  List<MonthGeneralData> monthData;
  List<MonthListInstancesModel> loadedMonthData;
  Function monthFunction;
  MonthlyTransactions({Key? key, required this.monthData, required this.monthFunction, required this.loadedMonthData}) : super(key: key);

  @override
  State<MonthlyTransactions> createState() => _MonthlyTransactionsState();
}

class _MonthlyTransactionsState extends State<MonthlyTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          homeCardView(child: headerTitleText("Monthly Transactions")),
          Flexible(child: MonthList(allMonths: widget.monthData, monthFunction: widget.monthFunction, loadedMonthData: widget.loadedMonthData))
        ],
      ),
    );
  }
}

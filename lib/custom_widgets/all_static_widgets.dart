import 'package:flutter/material.dart';
import 'package:personal_finance_app/models/month_general_data.dart';
import 'package:personal_finance_app/models/month_list_instances.dart';
import '../functions/functions.dart';
import '../models/month_instance_data.dart';
import '../screens/month_instance_items.dart';
import 'package:collection/collection.dart';

import '../services/getAMonthsData.dart';

Widget homeCardView({child}){
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: child,
    ),
  );
}

Widget monthListCardView({child}){
  return Card(
    margin: const EdgeInsets.only(left: 9, right: 9),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: child,
    ),
  );
}

Widget homeSummaryValues({required String label, required int value}){
  //Code for adding commas to the string
  String amount = convertMoneyToString(value);
  return Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 4),
    child: Row(
      children: [
        Text("$label: ", style: const TextStyle(
          fontSize: 22
        ),),
        Text(amount, style: const TextStyle(
            fontFamily:"Pragmatica",
          fontSize: 20
        ),)
      ],
    ),
  );
}

Widget headerTitleText(String name){
  return Text(name, style: const TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
      color: Colors.blue
  ));
}

Widget monthName(String name){
  return Text(name,
  style: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.brown
  ),);
}

Widget yearName(String year){
  return Text(year,
  style: const TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
    color: Colors.blueGrey
  ),);
}

Widget totalIncome(int income){
  String amount = convertMoneyToString(income);
  return Row(
    children: [
      Text("Income: ", style: TextStyle(
          color: Colors.green[900]
      )),
      Text(amount, style: const TextStyle(
          fontFamily:"Pragmatica",
          fontSize: 18
      ),)
    ],
  );
}

Widget totalSpending(int spending){
  String amount = convertMoneyToString(spending);
  return Row(
    children: [
      Text("Spendings: ", style: TextStyle(
        color: Colors.blue[900]
      ),),
      Text(amount, style: const TextStyle(
          fontFamily:"Pragmatica",
          fontSize: 15
      ))
    ],
  );
}

Widget eachMonth(MonthGeneralData theMonth, BuildContext context, Function monthFunction, List<MonthListInstancesModel> loadedMonthData){
  return ListTile(
    onTap: () async {
      //First check if the data for that month had been loaded if so load it if not get from database
      MonthListInstancesModel? theMonthWeLoading = loadedMonthData.firstWhereOrNull((element) => element.monthId == theMonth.monthId);
      if(theMonthWeLoading == null){
        //Get from API
        //First get the data from json file
        Map<dynamic, dynamic> theMonthFutureData = await readMonthData(theMonth.path);
        List<dynamic> theData = theMonthFutureData["spendings-instances"];
        //theMonthWeLoading = monthFunction(theMonth, theMonthFutureData);
        theMonthWeLoading = monthFunction(theMonth, theData);
      }
      //After getting from api we can open the screen
      if(theMonthWeLoading != null){
        //Open the month
        Navigator.push(context, MaterialPageRoute(builder: (context) => MonthInstanceItems(month: theMonthWeLoading!)));
      }
    },
    contentPadding: const EdgeInsets.all(15),
    title: Column(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        monthName(theMonth.label),
        yearName(theMonth.year)
      ],
    ),
    trailing: SizedBox(
      width: 190,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        totalIncome(theMonth.totalIncome),
        totalSpending(theMonth.totalSpending)
      ],
  ),
    )
  );
}

Widget monthlyInstanceTotalOutput(int income, Color? colour, label){
  String amount = convertMoneyToString(income);
  return
    Expanded(flex: 1, child: Column(
      children: [
        Text(label, style: TextStyle(
            color: colour,
          fontSize: 16
        )),
        Text(amount, style: const TextStyle(
            fontFamily:"Pragmatica",
            fontSize: 22
        ),)
      ],
    ));
}

Widget eachTransactionInstance(MonthInstanceModel theMonth){
  String theAmount = convertMoneyToString(theMonth.amount);
  return ListTile(
      contentPadding: const EdgeInsets.all(15),
      leading: Text(theMonth.label, style: const TextStyle(
          fontSize: 16
      )),

      title: Text(theAmount, style: TextStyle(
  fontFamily:"Pragmatica",
  color: Colors.green[900],
  fontSize: 14
  )),

      trailing: Text("${theMonth.day} ${theMonth.date}", style: TextStyle(
  color: Colors.blue[900],
          fontSize: 14
  ),)
  );
}

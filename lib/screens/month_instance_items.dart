import 'package:flutter/material.dart';

import '../custom_widgets/all_static_widgets.dart';
import '../models/month_list_instances.dart';

class MonthInstanceItems extends StatefulWidget {
  MonthListInstancesModel month;
  MonthInstanceItems({Key? key, required this.month}) : super(key: key);

  @override
  State<MonthInstanceItems> createState() => _MonthDetailsState();
}

class _MonthDetailsState extends State<MonthInstanceItems> with TickerProviderStateMixin  {
  final GlobalKey _listKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    TabController _myController = TabController(length: 3, vsync: this);

    Widget renderAnInstance(int where){
      List<Widget> selectedValues= [];
      switch(where){
        case 0: {
          selectedValues = widget.month.theItems.map((e) => eachTransactionInstance(e)).toList();
          break;
        }
        case 1:{
          selectedValues = (widget.month.theItems.where((element) => element.type)).map((e) => eachTransactionInstance(e)).toList();
          break;
        }
        case 2:{
          selectedValues = (widget.month.theItems.where((element) => !element.type)).map((e) => eachTransactionInstance(e)).toList();
          break;
        }
      }
      return Expanded(
        child: ListView.separated(key: _listKey, itemCount: selectedValues.length, scrollDirection: Axis.vertical, shrinkWrap: true, itemBuilder: (context, index) {
          return selectedValues[index];
        }, separatorBuilder: (BuildContext context, int index) { return const Divider(); },
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Monthly Transactions"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Text(widget.month.monthName, style: TextStyle(fontSize: 42, color: Colors.brown, fontWeight: FontWeight.bold),),
            Text(widget.month.year, style: TextStyle(fontSize: 32,color: Colors.blueGrey),),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  monthlyInstanceTotalOutput(widget.month.income, Colors.green[900],"Total Income"),
                  monthlyInstanceTotalOutput(widget.month.spendings,Colors.blue[900],"Total Spendings")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: TabBar(
                controller: _myController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs:[
                  Tab(text: "Monthly\nStatement"),
                  Tab(text: "Income\nOnly"),
                  Tab(text: "Spendings\nOnly")
                ]
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 400,
              child: TabBarView(
                controller: _myController,
                children: [
                  renderAnInstance(0),
                  renderAnInstance(1),
                  renderAnInstance(2),
                ],
              ),
            )
          ],

        ),
      ),
    );
  }
}

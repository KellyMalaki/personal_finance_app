import 'package:flutter/material.dart';
import 'package:personal_finance_app/models/month_general_data.dart';
import 'package:personal_finance_app/models/user_model.dart';
import 'package:personal_finance_app/screens/month_instance_items.dart';
import 'package:personal_finance_app/screens/monthly_transactions.dart';
import 'package:personal_finance_app/screens/profile_page.dart';
import 'package:personal_finance_app/services/getAMonthsData.dart';
import 'package:personal_finance_app/services/getDashboardData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'models/month_list_instances.dart';

void main() {
  runApp(const MainActivity());
}
class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  //Since data will come from backend we can't assign these till we get the data. Hence we use late to make them wait.
  late Future<Map<dynamic, dynamic>> allMainActivityData;
  late UserModel theUser;
  List<MonthGeneralData> monthGeneralData = [];
  late int currentIndex;
  late List<Widget> fragments;
  late List<dynamic> allDays;
  List<MonthListInstancesModel> loadedMonthData = [];
  void updateUserData(UserModel newUser){
    setState(() {
      theUser = newUser;
    });
  }
  MonthListInstancesModel getAMonthData(MonthGeneralData theMonth, List<dynamic> theData){
    //Future<List<dynamic>> theMonthFutureData = readMonthData(theMonth.path);
    MonthListInstancesModel monthData = MonthListInstancesModel.fromJsonMap(theData, theMonth.monthId, allDays, theMonth.label, theMonth.year, theMonth.totalIncome, theMonth.totalSpending);
    //Now add it to monthGeneralData
    loadedMonthData.add(monthData);
    return monthData;
  }

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    //Now we get the future value and we will use futurebuilder to display the data when it is ready
    allMainActivityData = readDashboardData();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white60
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: FutureBuilder<Map<dynamic, dynamic>>(
            future: allMainActivityData,
            builder:(context, myValue){
              if(myValue.hasData){
                Map<String, dynamic> user = myValue.data!["user"];
                //List<Map<String, dynamic>> months = myValue.data!["months"];
                //List<Map<String, dynamic>> allYears = myValue.data!["years"];
                List<dynamic> months = myValue.data!["months"];
                List<dynamic> allYears = myValue.data!["years"];
                allDays = myValue.data!["days"];
                theUser = UserModel.fromJsonMap(user);
                monthGeneralData = months.map((e) => MonthGeneralData.getFromAPI(e,allYears)).toList();
                fragments = [
                  ProfilePage(theUser: theUser, updateUserData: updateUserData),
                  MonthlyTransactions(monthData: monthGeneralData, loadedMonthData: loadedMonthData, monthFunction: getAMonthData),
                ];
                return IndexedStack(
                  index: currentIndex,
                  children: fragments,
                );
              }else{
                return Center(
                  child: SpinKitChasingDots(
                    color: Colors.blue[900],
                  ),
                );
              }
            }
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue[900],
            unselectedItemColor: Colors.grey,
            currentIndex: currentIndex,
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
              BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Transactions")
            ],
          ),
        ),
      )
    );
  }
}


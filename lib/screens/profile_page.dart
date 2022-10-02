import 'package:flutter/material.dart';
import 'package:personal_finance_app/custom_widgets/all_static_widgets.dart';
import 'package:personal_finance_app/screens/screen_layers/profile/profile_summary_row.dart';
import 'package:personal_finance_app/screens/screen_layers/profile/profile_top_row.dart';

import '../models/user_model.dart';

class ProfilePage extends StatefulWidget {
  UserModel theUser;
  Function updateUserData;

  ProfilePage({Key? key, required this.theUser, required this.updateUserData}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String career;
  late int balance;
  late int income;
  late int spendings;

  @override
  void initState() {
    super.initState();
    name = widget.theUser.name;
    career = widget.theUser.career;
    balance = widget.theUser.balance;
    income = widget.theUser.totalIncome;
    spendings = widget.theUser.totalSpending;
  }


  @override
  Widget build(BuildContext context) {
    void updateUserData(){
      UserModel newUser = UserModel.dataHandFilled(widget.theUser.image, name, career, balance, income, spendings);
      //widget.updateUserData(newUser);
      setState(() {
        widget.theUser = newUser;
      });
    }
    Future openSettings() =>  showDialog(context: context, builder: (context) => AlertDialog(title: Text("Edit User's Details"),





        //Edit user form
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(hintText: "Name"),
                initialValue: name.toString(),
                validator: (data) {
                  if(data != null){
                      return null;
                  }
                  return "Enter a name";
                },
                onChanged: (data){
                  setState(() {
                    name = data;
                  });
                },
              ),
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(hintText: "Career"),
            initialValue: career.toString(),
              validator: (data) {
                if(data != null){
                  return null;
                }
                return "Enter a career";
              },
                onChanged: (data){
                  setState(() {
                    career = data;
                  });
                },
          ),
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(hintText: "Balance"),
            initialValue: balance.toString(),
            keyboardType: TextInputType.number,
            validator: (data) {
              if(data != null){
                return null;
              }
              return "Enter Balance";
            },
                onChanged: (data){
                  setState(() {
                    balance = int.parse(data);
                  });
                },
          ),
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(hintText: "Income"),
            initialValue: income.toString(),
            keyboardType: TextInputType.number,
            validator: (data) {
              if(data != null){
                return null;
              }
              return "Enter a income";
            },
                onChanged: (data){
                  setState(() {
                    income = int.parse(data);
                  });
                },
          ),
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(hintText: "Spendings"),
            initialValue: spendings.toString(),
            keyboardType: TextInputType.number,
            validator: (data) {
              if(data != null){
                return null;
              }
              return "Enter a spendings";
            },
                onChanged: (data){
                  setState(() {
                    spendings = int.parse(data);
                  });
                },
          ),
  ])
        ),
        actions: [TextButton(onPressed: () {
          //Edit the data
          if(_formKey.currentState != null){
            if(_formKey.currentState!.validate()){
              Navigator.of(context).pop();
              updateUserData();
            }
          }
        }, child: const Text("Save Changes")),
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("Cancel"))
        ]
    ));
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.theUser.name}'s Profile"),
        centerTitle: false,
          actions: [IconButton(onPressed: openSettings, icon: const Icon(Icons.manage_accounts)),
    ]
      ),
      body: Column(
        children: [
          HomeTopRow(img: widget.theUser.image, name: widget.theUser.name, career: widget.theUser.career),
          const SizedBox(height: 12),
          ProfileSummaryRow(balance: widget.theUser.balance, income: widget.theUser.totalIncome, spendings: widget.theUser.totalSpending)
        ],
      ),
    );
  }
}

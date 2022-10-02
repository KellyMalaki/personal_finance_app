import 'package:flutter/material.dart';
import 'package:personal_finance_app/custom_widgets/all_static_widgets.dart';

class ProfileSummaryRow extends StatelessWidget {
  final int balance;
  final int income;
  final int spendings;
  const ProfileSummaryRow({Key? key, required this.balance, required this.income, required this.spendings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return homeCardView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: headerTitleText("Summary"),
          ),
          homeSummaryValues(label: "Balance", value: balance),
          homeSummaryValues(label: "Total Income", value: income),
          homeSummaryValues(label: "Total Spendings", value: spendings)
        ],
      )
    );
  }
}

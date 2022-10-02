import 'package:flutter/material.dart';
import 'package:personal_finance_app/custom_widgets/all_static_widgets.dart';

class HomeTopRow extends StatelessWidget {
  final String img;
  final String name;
  final String career;
  const HomeTopRow({Key? key, required this.img, required this.name, required this.career}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return homeCardView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: Image.asset(img),
                  ),
                ),
              ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style:const TextStyle(
                            fontSize: 32,
                          )
                        ),
                        const SizedBox(height: 12),
                        Text(career,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ]));
  }
}

import 'package:flutter/material.dart';
import 'package:hiring_assignment/constants.dart';
import 'package:hiring_assignment/widgets/custom_checkbox.dart';
import 'package:hiring_assignment/widgets/custom_outlined_button.dart';

class SelectWidgetsScreen extends StatefulWidget {
  const SelectWidgetsScreen({super.key});

  @override
  State<SelectWidgetsScreen> createState() => _SelectWidgetsScreenState();
}

class _SelectWidgetsScreenState extends State<SelectWidgetsScreen> {
  List<(String, bool?)> checkList = [
    ('Text Widget', false),
    ('Image Widget', false),
    ('Button Widget', false)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              for (int i = 0; i < checkList.length; i++)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: CustomCheckBox(
                      check: checkList,
                      i: i,
                      onChanged: (value) {
                        setState(() {
                          checkList[i] = (checkList[i].$1, value);
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
          Center(
            child: CustomOutlinedButton(
                buttonText: 'Import widgets',
                onPressed: () {
                  Navigator.pop(context, checkList);
                }),
          )
        ],
      ),
    );
  }
}

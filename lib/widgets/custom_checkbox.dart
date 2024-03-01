import 'package:flutter/material.dart';
import 'package:hiring_assignment/constants.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.check,
    required this.i,
    required this.onChanged,
  });

  final List<(String, bool?)> check;
  final int i;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          child: Checkbox(
            side: BorderSide.none,
            checkColor: kCheckBoxCheckColor,
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return kCheckBoxCheckColor; // Green when checked (fill color)
              }
              return Colors.grey[300]; // Grey when unchecked
            }),
            shape: const CircleBorder(),
            value: check[i].$2,
            onChanged: onChanged,
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.all(13),
            child: Text(
              check[i].$1,
              // textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

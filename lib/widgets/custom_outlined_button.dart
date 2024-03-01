import 'package:flutter/material.dart';
import 'package:hiring_assignment/constants.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {super.key, required this.buttonText, required this.onPressed, this.shape});

  final String buttonText;
  final VoidCallback onPressed;
  final OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(70, 50),
          foregroundColor: Colors.black,
          backgroundColor: kSecondaryColor,
          shape: shape,
        ),
        onPressed: onPressed,
        child: Text(buttonText));
  }
}

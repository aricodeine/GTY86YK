import 'package:flutter/material.dart';
import 'package:hiring_assignment/widgets/custom_outlined_button.dart';

class EnterTextDialog extends StatefulWidget {
  const EnterTextDialog({super.key});

  @override
  State<EnterTextDialog> createState() => _EnterTextDialogState();
}

class _EnterTextDialogState extends State<EnterTextDialog> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: 'Enter text',
            hintStyle: const TextStyle(fontWeight: FontWeight.bold),
            fillColor: Colors.grey[300],
            border: InputBorder.none,
            filled: true),
      ),
      actions: [
        CustomOutlinedButton(
            buttonText: 'Enter',
            onPressed: () {
              Navigator.pop(context, controller.text);
            }),
        CustomOutlinedButton(
            buttonText: 'Cancel',
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
  }
}

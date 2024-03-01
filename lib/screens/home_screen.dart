import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hiring_assignment/constants.dart';
import 'package:hiring_assignment/models/text_image.dart';
import 'package:hiring_assignment/screens/select_widgets_screen.dart';
import 'package:hiring_assignment/services/backend_service.dart';
import 'package:hiring_assignment/services/image_picker_service.dart';
import 'package:hiring_assignment/widgets/custom_filled_button.dart';
import 'package:hiring_assignment/widgets/custom_outlined_button.dart';
import 'package:hiring_assignment/widgets/enter_text_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextImage object = TextImage();
  List<(String, bool?)> checkList = [
    ('Text Widget', false),
    ('Image Widget', false),
    ('Button Widget', false)
  ];
  String saveError = '';
  String _displayText = 'Enter Text';
  File? selectedImage;
  String _displayImageUrl = '';
  // String _displayImageUrl = '';

  Future<void> _fetchLastUploadedText() async {
    _displayText = await BackendService.getLatestText();
    setState(() {});
  }

  Future<void> _fetchLastUploadedImage() async {
    _displayImageUrl = await BackendService.getLastUploadedImageUrl();
    setState(() {});
  }

  void displaySnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void initState() {
    super.initState();
    _fetchLastUploadedText();
    _fetchLastUploadedImage();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assignment App',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              height: deviceSize.height * 0.75,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (checkList[0].$2 == false &&
                          checkList[1].$2 == false &&
                          checkList[2].$2 == false)
                        const Text(
                          'No widget is added',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                        )
                      else if (checkList[0].$2 == false &&
                          checkList[1].$2 == false &&
                          checkList[2].$2 == true)
                        Text(
                          saveError,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      Visibility(
                        visible: checkList[0].$2!,
                        child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: CustomFilledButton(
                                onPressed: () async {
                                  final String? text = await showDialog(
                                      context: context,
                                      builder: (context) => const EnterTextDialog());
                                  object.text = text ?? '';
                                  debugPrint('Entered text: ${object.text}');
                                },
                                child: Text(_displayText, style: kFilledButtonTextStyle))),
                      ),
                      const SizedBox(height: 100),
                      Visibility(
                        visible: checkList[1].$2!,
                        child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: CustomFilledButton(
                                onPressed: () async {
                                  String? path = await ImagePickerService.pickImageFromGallery();
                                  if (path != null) {
                                    final File image = File(path);
                                    selectedImage = image;
                                  }
                                },
                                child: _displayImageUrl != ''
                                    ? Image.network(
                                        _displayImageUrl,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      )
                                    : const Text('Upload Image', style: kFilledButtonTextStyle))),
                      ),
                      const SizedBox(height: 50),
                      Visibility(
                        visible: checkList[2].$2!,
                        child: CustomOutlinedButton(
                            buttonText: 'Save',
                            shape: const BeveledRectangleBorder(),
                            onPressed: () async {
                              if (checkList[0].$2 == false && checkList[1].$2 == false) {
                                setState(() {
                                  saveError = 'Add at-least a widget to save';
                                });
                              } else {
                                final isUploaded =
                                    await BackendService.uploadObject(object, image: selectedImage);
                                print(isUploaded);
                                selectedImage = null;
                                _fetchLastUploadedText();
                                _fetchLastUploadedImage();
                                if (isUploaded) {
                                  displaySnackBar('Successfully saved');
                                } else {
                                  displaySnackBar('Saving unsuccessful');
                                }
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            CustomOutlinedButton(
                buttonText: 'Add Widgets',
                onPressed: () async {
                  checkList = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectWidgetsScreen(),
                      ));
                  setState(() {
                    saveError = '';
                  });
                }),
          ]),
        ),
      ),
    );
  }
}

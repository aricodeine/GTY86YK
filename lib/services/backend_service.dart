import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:hiring_assignment/models/text_image.dart';
import 'package:path/path.dart' show basename;

class BackendService {
  static CollectionReference tempCollection = FirebaseFirestore.instance.collection('temp');
  static Reference ref = FirebaseStorage.instance.ref();
  static UploadTask? _uploadTask;

  static Future<bool> uploadObject(TextImage object, {File? image}) async {
    try {
      if (image != null) {
        final String url = await uploadImage(image);
        object.imageLink = url;
      }

      Map<String, dynamic> objectWithTimestamp = object.toMap();
      objectWithTimestamp['timestamp'] = FieldValue.serverTimestamp();
      await tempCollection.add(objectWithTimestamp);

      debugPrint("Text Added");
      return true;
    } catch (error) {
      debugPrint("Failed to add text: $error");
      return false;
    }
  }

  static getLatestText() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('temp')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final lastDocument = querySnapshot.docs.first;
        return lastDocument['text'];
      } else {
        return 'Enter Text'; // no text uploaded
      }
    } catch (e) {
      return 'Error fetching data';
    }
  }

  static Future<String> uploadImage(File file) async {
    final path = 'images/${basename(file.path)}';
    ref = ref.child(path);
    _uploadTask = ref.putFile(file);
    final snapshot = await _uploadTask!.whenComplete(() => null);

    final urlDownload = await snapshot.ref.getDownloadURL();
    debugPrint('Download Link: $urlDownload');

    return urlDownload;
  }

  static Future<String> getLastUploadedImageUrl() async {
    final Reference storageRef = FirebaseStorage.instance.ref().child('images');
    ListResult result = await storageRef.listAll();
    if (result.items.isEmpty) return '';
    Reference lastImageRef = result.items.last;
    String downloadUrl = await lastImageRef.getDownloadURL();

    return downloadUrl;
  }
}

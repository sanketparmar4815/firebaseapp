import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseapp/ViewDatatt.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageAndimage extends StatefulWidget {
  @override
  State<StorageAndimage> createState() => _StorageAndimageState();
}

class _StorageAndimageState extends State<StorageAndimage> {
  String imagepath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
// Pick an image.
                final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  imagepath = image!.path;
                });
// Create a storage reference from our app
              },
              child: CircleAvatar(
                radius: 70,
                backgroundImage: FileImage(File(imagepath)),
              )),
          ElevatedButton(
              onPressed: () async {
                final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"

// Create a reference to 'images/mountains.jpg'

                DateTime dd = DateTime.now();
                String imagename = '${dd.hour}${dd.second}.jpg';

                final mountainImagesRef =
                storageRef.child("RoackStorage/$imagename");

                await mountainImagesRef.putFile(File(imagepath));

                mountainImagesRef.getDownloadURL().then((value) async {
                  print("===${value}");

                  DatabaseReference ref =
                  FirebaseDatabase.instance.ref("Mydatabse").push();
                  String? id = ref.key;

                  await ref.set({
                    "id": id,
                    "name": "Creative",
                    "age": 18,
                    "imageurl": value
                  }).then((value) {




                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => MyviewDatatatataattatatat(),));
                  });
                });
              },
              child: Text("Insert to Image"))
        ],
      ),
    );
  }
}

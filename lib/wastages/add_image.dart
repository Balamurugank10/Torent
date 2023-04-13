import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool uploading = false;
  double val = 0;

  late CollectionReference imgRef;
  late firebase_storage.Reference ref;

  final List<File> _image = [];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('add'),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    uploading = true;
                  });
                  uploadFile().whenComplete(() => Navigator.of(context).pop());
                },
                child: const Text(
                  'upload',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Stack(
          children: [
            GridView.builder(
                itemCount: _image.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return index == 0
                      ? Center(
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: (() =>
                                !uploading ? chooseImage() : null),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(_image[index - 1]))),
                        );
                }),
            uploading
                ? Center(
                    child: Column(children: [
                      Container(
                        child: const Text('Uplooadng'),
                      ),
                      CircularProgressIndicator(
                        value: val,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.green),
                      )
                    ]),
                  )
                : Container(),
          ],
        ));
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });

    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          print(value);
          imgRef.add({'url': value});
          i++;
        });
      });
      print(ref);
    }

    @override
    void initState() {
      super.initState();
      imgRef = FirebaseFirestore.instance.collection('users');
    }
  }
}

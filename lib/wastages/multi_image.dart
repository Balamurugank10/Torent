import 'package:flutter/material.dart';

class MutliImage extends StatefulWidget {
  const MutliImage({super.key});

  @override
  State<MutliImage> createState() => _MutliImageState();
}

class _MutliImageState extends State<MutliImage> {
  String img = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add'),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text(
                'upload',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}


// FloatingActionButton(onPressed: () async {
//                   ImagePicker imagePicker = ImagePicker();
//                   XFile? file =
//                       await imagePicker.pickImage(source: ImageSource.gallery);

//                   print('${file?.path}');

//                   if (file == null) return;

//                   String uniqueFileName =
//                       DateTime.now().microsecondsSinceEpoch.toString();

//                   //upload to storage
//                   //get a reference to storage root
//                   Reference referenceRoot = FirebaseStorage.instance.ref();
//                   Reference referenceDirImages = referenceRoot.child('images');

//                   //create a reference for the image to be stored..
//                   Reference referenceImageToUpload =
//                       referenceDirImages.child(uniqueFileName);

//                   //store the file
//                   await referenceImageToUpload.putFile(File(file.path));

//                   //get the url
//                   img = await referenceImageToUpload.getDownloadURL();
//                   print(img);
//                 }),

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:intl/intl.dart';
import '../notification_services.dart';
import '../a.dart';
import '../user.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sms/flutter_sms.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<String> mobiles = ['8015677832', '8825772826'];
  GlobalKey<FormState> formKey = GlobalKey();

  final ageController = TextEditingController();
  final monthlyRentController = TextEditingController();
  final maintenanceController = TextEditingController();
  final sqftController = TextEditingController();
  final descriptionController = TextEditingController();

  final flatNoController = TextEditingController();
  final streetController = TextEditingController();
  final areaController = TextEditingController();

  final pincodeController = TextEditingController();
  final landmarkController = TextEditingController();
  final carpetAreaController = TextEditingController();

  final nameOwnerController = TextEditingController();
  final mobileOwnerController = TextEditingController();
  final emailOwnerController = TextEditingController();

  final availableDateController = TextEditingController();
  late String propertyType;
  late String bedrooms;
  late String furnishedType;
  late String bathrooms;
  late String parking;

  String country = "";
  String state = "";
  String city = "";

  String img = "";

  List<String> multipleImages = [];
  final userAuth = FirebaseAuth.instance.currentUser!.email;

  void sendingSMS(String msg, List<String> listReceipents) async {
    String sendResult = await sendSMS(message: msg, recipients: listReceipents)
        .catchError((err) {
      print(err);
    });
    print(sendResult);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: const [
                    Text('*',
                        style: TextStyle(color: Colors.red, fontSize: 24)),
                    Text(
                      'indicates a mandatory field',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                labels('Property Type', true),
                const SizedBox(height: 10),
                CustomRadioButton(
                    buttonLables: const [
                      'Independent House',
                      'Apartment',
                      'Residency',
                      'Villa'
                    ],
                    buttonValues: const [
                      'HOUSE',
                      'APARTMENT',
                      'RESIDENCY',
                      'VILLA'
                    ],
                    buttonTextStyle: const ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.grey),
                    radioButtonValue: (value) {
                      setState(() {
                        propertyType = value;
                      });
                    },
                    autoWidth: true,
                    enableShape: true,
                    selectedBorderColor: Colors.blue,
                    enableButtonWrap: true,
                    unSelectedBorderColor: Colors.grey,
                    unSelectedColor: Colors.white,
                    selectedColor: Colors.blue),
                const SizedBox(height: 15),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Age of Property in years "),
                          Text('*', style: TextStyle(color: Colors.red)),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                        ],
                      ),
                      floatingLabelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder()),
                  onSaved: (newValue) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Age is Required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                labels('Bathrooms', true),
                const SizedBox(height: 10),
                CustomRadioButton(
                    buttonLables: const [
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                    ],
                    buttonValues: const [
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                    ],
                    buttonTextStyle: const ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.grey),
                    radioButtonValue: (value) {
                      setState(() {
                        bathrooms = value;
                      });
                    },
                    autoWidth: true,
                    enableShape: true,
                    selectedBorderColor: Colors.blue,
                    enableButtonWrap: true,
                    unSelectedBorderColor: Colors.grey,
                    unSelectedColor: Colors.white,
                    selectedColor: Colors.blue),
                const SizedBox(height: 15),
                labels('BedRooms', true),
                const SizedBox(height: 10),
                CustomRadioButton(
                    buttonLables: const ['1', '2', '3', '4', '5', '6'],
                    buttonValues: const ['1', '2', '3', '4', '5', '6'],
                    buttonTextStyle: const ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.grey),
                    radioButtonValue: (value) {
                      setState(() {
                        bedrooms = value;
                      });
                    },
                    autoWidth: true,
                    enableShape: true,
                    selectedBorderColor: Colors.blue,
                    enableButtonWrap: true,
                    unSelectedBorderColor: Colors.grey,
                    unSelectedColor: Colors.white,
                    selectedColor: Colors.blue),
                const SizedBox(height: 15),
                labels('Furnish Type', true),
                const SizedBox(height: 10),
                CustomRadioButton(
                    buttonLables: const [
                      'Fully Furnished',
                      'Semi Furnished',
                      'Unfurnished',
                    ],
                    buttonValues: const [
                      'Fully Furnished',
                      'Semi Furnished',
                      'Unfurnished',
                    ],
                    buttonTextStyle: const ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.grey),
                    radioButtonValue: (value) {
                      setState(() {
                        furnishedType = value;
                      });
                    },
                    autoWidth: true,
                    enableShape: true,
                    selectedBorderColor: Colors.blue,
                    enableButtonWrap: true,
                    unSelectedBorderColor: Colors.grey,
                    unSelectedColor: Colors.white,
                    selectedColor: Colors.blue),
                const SizedBox(height: 15),
                labels('Parking', true),
                const SizedBox(height: 10),
                CustomRadioButton(
                    buttonLables: const ['1', '2', '3'],
                    buttonValues: const ['1', '2', '3'],
                    buttonTextStyle: const ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.grey),
                    radioButtonValue: (value) {
                      setState(() {
                        parking = value;
                      });
                    },
                    autoWidth: true,
                    enableShape: true,
                    selectedBorderColor: Colors.blue,
                    enableButtonWrap: true,
                    unSelectedBorderColor: Colors.grey,
                    unSelectedColor: Colors.white,
                    selectedColor: Colors.blue),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () async {
                      List<XFile>? images = await multiImagePicker();
                      if (images.isNotEmpty) {
                        multipleImages = await mip(images);
                        print('multi images: $multipleImages');
                      }
                    },
                    child: const Text('Upload Images')),
                const SizedBox(height: 15),
                TextFormField(
                  readOnly: true,
                  controller: availableDateController,
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat("yyyy-MM-dd").format(pickedDate);

                      setState(() {
                        availableDateController.text = formattedDate.toString();
                      });
                    }
                  },
                  decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_today),
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("Available from "),
                        Text('*', style: TextStyle(color: Colors.red)),
                        Padding(
                          padding: EdgeInsets.all(3.0),
                        ),
                      ],
                    ),
                    floatingLabelStyle: const TextStyle(color: Colors.purple),
                  ),
                  onSaved: (newValue) {},
                  validator: (value) {
                    return value!.isEmpty ? 'Required field' : null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: monthlyRentController,
                  validator: (value) {
                    return value!.isEmpty ? 'Rent is required' : null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Monthly Rent "),
                          Text('*', style: TextStyle(color: Colors.red)),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                        ],
                      ),
                      prefix: const Text('₹ '),
                      floatingLabelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder()),
                  onSaved: (newValue) {},
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: maintenanceController,
                  validator: (value) {
                    return value!.isEmpty ? 'Required field' : null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefix: Text('₹ '),
                      labelText: 'Maintenance Charges(per month)',
                      floatingLabelStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder()),
                  onSaved: (newValue) {},
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: sqftController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Built Up Area "),
                          Text('*', style: TextStyle(color: Colors.red)),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                        ],
                      ),
                      suffix: const Text('Sq. ft.'),
                      floatingLabelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder()),
                  onSaved: (newValue) {},
                  validator: (value) {
                    return value!.isEmpty ? 'Required field' : null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: "Description about your property in 100 words",
                      suffix: Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder()),
                  onSaved: (newValue) {},
                  validator: (value) {
                    return value!.isEmpty ? 'Required field' : null;
                  },
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 30),
                const Text(
                  'Address Details',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 10),
                CSCPicker(
                  showCities: true,
                  showStates: true,
                  defaultCountry: CscCountry.India,
                  disableCountry: true,
                  countryDropdownLabel: "Country*",
                  stateDropdownLabel: "State*",
                  cityDropdownLabel: "City*",
                  layout: Layout.vertical,
                  onCountryChanged: (value) {
                    setState(() {
                      country = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      state = value.toString();
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      city = value.toString();
                    });
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: areaController,
                  decoration: InputDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Area "),
                          Text('*', style: TextStyle(color: Colors.red)),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                        ],
                      ),
                      floatingLabelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder()),
                  onSaved: (newValue) {},
                  validator: (value) {
                    return value!.isEmpty ? 'Area Required' : null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: streetController,
                  decoration: const InputDecoration(
                      labelText: 'Street',
                      floatingLabelStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder()),
                  onSaved: (newValue) {},
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: flatNoController,
                  decoration: InputDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Flat No "),
                          Text('*', style: TextStyle(color: Colors.red)),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                        ],
                      ),
                      prefix: const Text('No. '),
                      floatingLabelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder()),
                  onSaved: (newValue) {},
                  validator: (value) {
                    return value!.isEmpty ? 'Required field' : null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: pincodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Pincode "),
                          Text('*', style: TextStyle(color: Colors.red)),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                        ],
                      ),
                      floatingLabelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder()),
                  onSaved: (newValue) {},
                  validator: (value) {
                    if (value!.length != 6) {
                      return 'Pincode must be 6 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: landmarkController,
                  decoration: InputDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Landmark "),
                          Text('*', style: TextStyle(color: Colors.red)),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                        ],
                      ),
                      floatingLabelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder()),
                  onSaved: (newValue) {},
                  validator: (value) {
                    return value!.isEmpty ? 'Required field' : null;
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                  'Owner Details',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameOwnerController,
                  decoration: InputDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Name "),
                          Text('*', style: TextStyle(color: Colors.red)),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                        ],
                      ),
                      floatingLabelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder()),
                  onSaved: (newValue) {},
                  validator: (value) {
                    return value!.isEmpty ? 'Required field' : null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: mobileOwnerController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Mobile No "),
                          Text('*', style: TextStyle(color: Colors.red)),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                        ],
                      ),
                      prefix: const Text('+91 '),
                      floatingLabelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder()),
                  onSaved: (newValue) {},
                  validator: (value) {
                    if (value!.length != 10) {
                      return 'Mobile number contain 10 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (formKey.currentState!.validate()) {}
                        if (multipleImages == []) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please upload image')));
                          return;
                        }
                        mobiles.add(mobileOwnerController.text.toString());
                      });

                      final user = Userdb(
                        name: nameOwnerController.text,
                        age: int.parse(ageController.text),
                        bedrooms: int.parse(bedrooms),
                        bathrooms: int.parse(bathrooms),
                        area: areaController.text,
                        carpet: 78.0,
                        city: city,
                        description: descriptionController.text,
                        email: userAuth.toString(),
                        flatno: flatNoController.text,
                        furnished: furnishedType,
                        landmark: landmarkController.text,
                        maintenance: int.parse(maintenanceController.text),
                        mobile: int.parse(mobileOwnerController.text),
                        parking: int.parse(parking),
                        pincode: int.parse(pincodeController.text),
                        propType: propertyType,
                        rent: int.parse(monthlyRentController.text),
                        sqft: double.parse(sqftController.text),
                        state: state,
                        country: country,
                        street: streetController.text,
                        availableDate:
                            DateTime.parse(availableDateController.text),
                        isfavorite: false,
                        multipleImages: multipleImages,
                      );

                      createUser(user)
                          .then((value) => NotificationService().showNotification(
                              title: 'TORENT',
                              body:
                                  'Hai ${nameOwnerController.text}...  Your Property Will Posted Successfully'))
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      });
                      print('djkd $multipleImages');

                      // Navigator.pop(context);
                    },
                    child: const Text('Submit')),
                const SizedBox(height: 15),
              ],
            ))
      ],
    );
  }

  Future<List<String>> mip(List<XFile> list) async {
    List<String> path = [];

    print("Store image path");
    for (XFile i in list) {
      path.add(await uploadImage(i));
    }

    return path;
  }

  Future<List<XFile>> multiImagePicker() async {
    print("Inside the MultiImage picker");
    List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      print("Multi image is not empty condition");
      print(images);
      return images;
    }
    return [];
  }

  Future<String> uploadImage(XFile image) async {
    Reference db =
        FirebaseStorage.instance.ref("images/${getImageName(image)}");
    await db.putFile(File(image.path));
    final downloadedFile = await db.getDownloadURL();
    print("Downloaded FB path:" + downloadedFile);
    return downloadedFile;
  }

  //Return image name
  String getImageName(XFile image) {
    return image.path.split("/").last;
  }

  Future createUser(Userdb user) async {
    //Reference to a document...
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;

    final json = user.toJson();

    // Create document in cloud firestore and write data to firebase...
    await docUser.set(json);
  }
}

Widget labels(String text, bool requiredField) {
  return Row(children: [
    Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 24),
    ),
    requiredField
        ? const Text('*', style: TextStyle(color: Colors.red, fontSize: 24))
        : const Text('')
  ]);
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:intl/intl.dart';
import '../user.dart';
import './add_image.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
//import '../validator/emailValidator.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  // String? _validateEmail(String value) {
  //   if (value.isEmpty) {
  //     // The form is empty
  //     return "Enter email address";
  //   }
  //   // This is just a regular expression for email addresses
  //   String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
  //       "\\@" +
  //       "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
  //       "(" +
  //       "\\." +
  //       "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
  //       ")+";
  //   RegExp regExp = RegExp(p);

  //   if (regExp.hasMatch(value)) {
  //     // So, the email is valid
  //     return null;
  //   }

  //   // The pattern of the email didn't match the regex above.
  //   return 'Email is not valid';
  // }

  final ageController = TextEditingController();
  final monthlyRentController = TextEditingController();
  final maintenanceController = TextEditingController();
  final sqftController = TextEditingController();
  final descriptionController = TextEditingController();

  final flatNoController = TextEditingController();
  final streetController = TextEditingController();
  final areaController = TextEditingController();
  //final cityController = TextEditingController();
  //final stateController = TextEditingController();
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
                    Text('* ',
                        style: TextStyle(color: Colors.red, fontSize: 24)),
                    Text(
                      'indicates a mandatory field',
                      style: TextStyle(color: Colors.black, fontSize: 24),
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
                    //wrapAlignment: WrapAlignment.start,
                    enableShape: true,
                    selectedBorderColor: Colors.blue,
                    enableButtonWrap: true,
                    unSelectedBorderColor: Colors.grey,
                    //width: 100,
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
                  onChanged: (value) {},
                  onSaved: (newValue) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                    // return value!.isEmpty ? 'Required field' : null;
                  },
                ),
                const SizedBox(height: 15),
                labels('Bathrooms', true),
                const SizedBox(height: 10),
                CustomRadioButton(
                    buttonLables: const [
                      '0',
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                    ],
                    buttonValues: const [
                      '0',
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
                    //wrapAlignment: WrapAlignment.start,
                    enableShape: true,
                    selectedBorderColor: Colors.blue,
                    enableButtonWrap: true,
                    unSelectedBorderColor: Colors.grey,
                    //width: 100,
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
                    //wrapAlignment: WrapAlignment.start,
                    enableShape: true,
                    selectedBorderColor: Colors.blue,
                    enableButtonWrap: true,
                    unSelectedBorderColor: Colors.grey,
                    //width: 100,
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
                    //wrapAlignment: WrapAlignment.start,
                    enableShape: true,
                    selectedBorderColor: Colors.blue,
                    enableButtonWrap: true,
                    unSelectedBorderColor: Colors.grey,
                    //width: 100,
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
                    //wrapAlignment: WrapAlignment.start,
                    enableShape: true,
                    selectedBorderColor: Colors.blue,
                    enableButtonWrap: true,
                    unSelectedBorderColor: Colors.grey,
                    //width: 100,
                    unSelectedColor: Colors.white,
                    selectedColor: Colors.blue),
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
                    //border: const OutlineInputBorder()
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
                    return value!.isEmpty ? 'Required field' : null;
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
                  controller: carpetAreaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      // suffixText: 'data',
                      suffix: Text('Sq. ft.'),
                      labelText: 'Carpet Area(Optional)',
                      floatingLabelStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder()),
                  onSaved: (newValue) {},
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
                    return value!.isEmpty ? 'Required field' : null;
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
                    return value!.length != 6 ? 'Required field' : null;
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
                    return value!.isEmpty ? 'Required field' : null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: emailOwnerController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  validator: (value) =>
                      value != null && !EmailValidator.validate(value)
                          ? 'Enter a valid Email'
                          : null,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Email "),
                          Text('*', style: TextStyle(color: Colors.red)),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                        ],
                      ),
                      floatingLabelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder()),
                  onSaved: (newValue) {},
                ),
                FloatingActionButton(onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);

                  print('${file?.path}');

                  if (file == null) return;

                  String uniqueFileName =
                      DateTime.now().microsecondsSinceEpoch.toString();

                  //upload to storage
                  //get a reference to storage root
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images');

                  //create a reference for the image to be stored..
                  Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);

                  //store the file
                  await referenceImageToUpload.putFile(File(file.path));

                  //get the url
                  img = await referenceImageToUpload.getDownloadURL();
                  print(img);
                }),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (formKey.currentState!.validate()) {}
                        if (img.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please upload image')));
                          return;
                        }
                      });

                      final user = User(
                        name: nameOwnerController.text,
                        age: int.parse(ageController.text),
                        bedrooms: int.parse(bedrooms),
                        bathrooms: int.parse(bathrooms),
                        area: areaController.text,
                        carpet: double.parse(carpetAreaController.text),
                        city: city,
                        description: descriptionController.text,
                        email: emailOwnerController.text,
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
                        img: img,
                        isfavorite: false,
                        multipleImages: ["img", "img"],
                      );
                      // final user = User(
                      //     //id: DateTime.now().toString(),
                      //     name: nameOwnerController.text,
                      //     age: int.parse(ageController.text),
                      //     availableDate: DateTime(2019, 10, 12)
                      //     //availableDate: DateTime(availableDateController.toString())
                      //     );

                      createUser(user);

                      //Navigator.pop(context);
                    },
                    child: const Text('Submit')),
                const SizedBox(height: 15),
              ],
            ))
      ],
    );
  }

  Future createUser(User user) async {
    //Reference to a document...
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;
    // final json = {
    //   'name': 'bala',
    //   'age': age,
    // };

    // final user = User(
    //     id: docUser.id,
    //     name: 'bala',
    //     age: 2,
    //     availableDate: DateTime(2019, 10, 12));
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

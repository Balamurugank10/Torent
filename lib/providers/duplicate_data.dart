import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_rent/a.dart';
import '../user.dart';
//import 'package:firebase_storage_platform_interface/firebase_storage_platform_interface.dart';

class DuplicateData with ChangeNotifier {
  // A findById(String id) {
  //   return data.firstWhere((prod) => prod.id == id);
  //   // return _items.firstWhere((element) => element.id == id);
  // }
}

const List<Map<String, dynamic>> data = [
  {
    'age': 5,
    'area': "ff ko9",
    'bathrooms': 5,
    'bedrooms': 3,
    'carpet': 4563,
    'city': "ruio",
    'country': "ind",
    'date': 'March 30, 2025 at 12:00:00 AM UTC+5:30',
    'description': "chu",
    'email': "fhkft",
    'flatno': "fji",
    'furnished': "Semi Furnished",
    'id': "TSIgjS21c4ax3CYeNzrL",
    'landmark': "fhj",
    'maintenance': 56,
    'mobile': 5666,
    'name': "6666",
    'parking': 3,
    'pincode': 56,
    'rent': 5,
    'sqft': 5555,
    'state': "dd hi oi",
    'street': "fjo",
    'type': "HOUSE",
  },
  {
    'age': 5,
    'area': "ff ko9",
    'bathrooms': 5,
    'bedrooms': 3,
    'carpet': 4563,
    'city': "ruio",
    'country': "ind",
    'date': 'March 30, 2025 at 12:00:00 AM UTC+5:30',
    'description': "chu",
    'email': "fhkft",
    'flatno': "fji",
    'furnished': "Semi Furnished",
    'id': "TSIgjS21c4ax3CYeNhjjzrL",
    'landmark': "fhj",
    'maintenance': 56,
    'mobile': 5666,
    'name': "6666",
    'parking': 3,
    'pincode': 56,
    'rent': 5,
    'sqft': 5555,
    'state': "dd hi oi",
    'street': "fjo",
    'type': "HOUSE",
  },
  {
    'age': 5,
    'area': "ff ko9",
    'bathrooms': 5,
    'bedrooms': 3,
    'carpet': 4563,
    'city': "ruio",
    'country': "ind",
    'date': 'March 30, 2025 at 12:00:00 AM UTC+5:30',
    'description': "chu",
    'email': "fhkft",
    'flatno': "fji",
    'furnished': "Semi Furnished",
    'id': "TSIgjS21c4axvv3CYeNzrL",
    'landmark': "fhj",
    'maintenance': 56,
    'mobile': 5666,
    'name': "6666",
    'parking': 3,
    'pincode': 56,
    'rent': 5,
    'sqft': 5555,
    'state': "dd hi oi",
    'street': "fjo",
    'type': "HOUSE",
  },
];

addData() async {
  for (var element in data) {
    FirebaseFirestore.instance.collection('users').add(element);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CategoryOutline with ChangeNotifier {
  final String id;

  final List imglist;

  //final String address;
  final String landmark;
  final String city;

  final String state;
  final String houseNo;
  final String country;
  final int amount;
  final String street;
  final int bedRooms;
  final int bathRooms;
  final double sqft;
  final int garage;
  final String type;
  final int pincode;
  final String description;
  final String ownerName;
  final int mobile;
  final String email;
  final String area;
  bool isFavorite;

  CategoryOutline(
      {required this.id,
      required this.imglist,
      required this.type,
      required this.amount,
      required this.sqft,
      required this.houseNo,
      required this.street,
      required this.city,
      required this.state,
      required this.country,
      required this.landmark,
      required this.area,
      required this.description,
      required this.email,
      required this.mobile,
      required this.ownerName,
      required this.pincode,
      //required this.city,
      required this.bathRooms,
      required this.bedRooms,
      required this.garage,
      this.isFavorite = false});

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

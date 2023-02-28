import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CategoryOutline with ChangeNotifier {
  final String id;

  final String imageUrl;

  final String address;
  final int amount;
  final double bedRooms;
  final double bathRooms;
  final double sqft;
  final double garage;
  final String type;

  bool isFavorite;

  CategoryOutline(
      {required this.id,
      required this.imageUrl,
      required this.type,
      required this.amount,
      required this.sqft,
      required this.address,
      required this.bathRooms,
      required this.bedRooms,
      required this.garage,
      this.isFavorite = false});

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

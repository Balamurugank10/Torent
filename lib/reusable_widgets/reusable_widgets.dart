import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Image logoWidget(String ImageName) {
  return Image.asset(
    ImageName,
    fit: BoxFit.cover,
    width: 140,
    height: 100,
  );
}

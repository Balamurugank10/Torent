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

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
    decoration: InputDecoration(
      labelText: text,
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelStyle: TextStyle(
        color: Colors.black.withOpacity(0.9),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
  );
}

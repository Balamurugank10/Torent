import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Image logoWidget(String ImageName) {
  return Image.asset(
    ImageName,
    fit: BoxFit.cover,
    width: 140,
    height: 140,
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
      //floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
  );
}


// Container FirebaseButton(BuildContext context, String title, Function onTap) {
//   return Container(
//     width: MediaQuery.of(context).size.width,
//     height: 50,
//     decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
//     child: ElevatedButton(
//       onPressed: () {
//         onTap;
//       },
//       style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.resolveWith((states) {
//             if (states.contains(MaterialState.pressed)) {
//               return Colors.white;
//             }
//             return const Color(0x61a82f2f);
//           }),
//           shape: MaterialStateProperty.all(RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ))),
//       child: Text(
//         title,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 16,
//         ),
//       ),
//     ),
//   );
// }

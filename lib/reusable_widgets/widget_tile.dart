import 'package:flutter/material.dart';

class WidgetTile extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  final String imagePath2;
  const WidgetTile(
      {super.key,
      required this.imagePath,
      required this.imagePath2,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3.2),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[200]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 40,
              ),
              Image.asset(
                imagePath2,
                height: 40,
              ),
            ],
          )),
    );
  }
}

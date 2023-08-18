import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0,
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ], color: Color(0xffefedfe), borderRadius: BorderRadius.circular(16)),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

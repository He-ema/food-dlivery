import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, this.onTap});
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
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
          icon,
          size: 35,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

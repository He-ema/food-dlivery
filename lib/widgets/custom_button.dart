import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.text,
    this.color,
    this.Textcolor,
    this.alternativeText,
  });

  final String text;
  final Color? color;
  final Color? Textcolor;
  final Text? alternativeText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(25),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color ?? Theme.of(context).primaryColor,
        ),
        child: Center(
            child: alternativeText ??
                Text(
                  text,
                  style: TextStyle(
                    color: Textcolor ?? Colors.white,
                  ),
                )),
      ),
    );
  }
}

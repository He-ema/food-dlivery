import 'package:flutter/material.dart';

class OutsideRegister extends StatelessWidget {
  const OutsideRegister(
      {super.key,
      required this.image,
      required this.text,
      required this.color,
      this.onTap});
  final String image, text;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(16),
          color: color,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Spacer(),
          Image.asset(
            image,
            width: 25,
            height: 25,
          ),
          Spacer(),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          Spacer(),
        ]),
      ),
    );
  }
}

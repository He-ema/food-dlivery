import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hint,
      this.maxLines = 1,
      this.onSaved,
      this.onChanged,
      this.controller,
      this.icon});
  final TextEditingController? controller;
  final String hint;
  final int maxLines;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    bool isUername = false;
    hint == 'User Name' ? isUername = true : false;
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: (value) {
        if (value!.isEmpty ?? true) {
          return 'This field can\'t be empty';
        } else {
          if (isUername && value.contains(' ')) {
            return 'User Name cant have spaces';
          } else {
            return null;
          }
        }
      },
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: icon,
        border: buildBorder(Theme.of(context).primaryColor),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: buildBorder(Theme.of(context).primaryColor),
        focusedBorder: buildBorder(Theme.of(context).primaryColor),
      ),
    );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          width: 0.1,
          color: color ?? const Color.fromARGB(255, 107, 106, 106),
        ));
  }
}

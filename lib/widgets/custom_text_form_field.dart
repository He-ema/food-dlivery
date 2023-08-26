import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {super.key,
      required this.hint,
      this.maxLines = 1,
      this.onSaved,
      this.onChanged,
      this.controller,
      this.icon,
      this.color,
      this.isPassword = false});
  final TextEditingController? controller;
  final String hint;
  final int maxLines;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Icon? icon;
  final bool isPassword;
  Color? color;
  bool obscureText = true;
  IconButton? iconButton;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    bool isUername = false;
    widget.hint == 'User Name' ? isUername = true : false;
    return TextFormField(
      obscureText: (widget.isPassword && widget.obscureText),
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
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
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  widget.obscureText = !widget.obscureText;
                  setState(() {});
                },
                child: widget.obscureText
                    ? Icon(
                        Icons.visibility,
                        color: Theme.of(context).primaryColor,
                      )
                    : Icon(Icons.visibility_off,
                        color: Theme.of(context).primaryColor))
            : null,
        filled: true,
        fillColor: widget.color ?? Colors.white,
        prefixIcon: widget.icon,
        border: buildBorder(Theme.of(context).primaryColor),
        hintText: widget.hint,
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

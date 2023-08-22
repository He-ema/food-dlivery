import 'package:flutter/material.dart';

class OTPField extends StatelessWidget {
  const OTPField(
      {super.key,
      required this.onSaved,
      required this.onChanged,
      this.controller});
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextFormField(
        controller: controller,
        onSaved: onSaved,
        onChanged: onChanged,
        autofocus: true,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(counterText: ''),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

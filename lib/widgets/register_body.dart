import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/images/Group 1909.png',
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          CustomTextFormField(
            hint: 'User Name',
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
            ),
          ),
          CustomTextFormField(
            hint: 'Email',
            icon: Icon(
              Icons.email,
              color: Theme.of(context).primaryColor,
            ),
          ),
          CustomTextFormField(
            hint: 'Password',
            icon: Icon(
              Icons.lock,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

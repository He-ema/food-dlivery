import 'package:flutter/material.dart';
import 'package:food/widgets/custom_button.dart';

import 'custom_text_form_field.dart';
import 'outside_register.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              Image.asset(
                'assets/images/Group 1909.png',
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Sign up for free',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 25,
              ),
              CustomTextFormField(
                hint: 'User Name',
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                hint: 'Email',
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                hint: 'Password',
                icon: Icon(
                  Icons.lock,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  OutsideRegister(
                    image: 'assets/images/facebook.png',
                    text: 'Facebook',
                    color: Color(0xff3a559f),
                  ),
                  Spacer(),
                  OutsideRegister(
                    image: 'assets/images/search.png',
                    text: 'Google',
                    color: Color.fromARGB(255, 46, 112, 167),
                  ),
                ],
              ),
              CustomButton(text: 'Create account'),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Alraedy have an account ?',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

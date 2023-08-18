import 'package:flutter/material.dart';
import 'package:food/views/OTP_view.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:food/widgets/custom_text_form_field.dart';

import 'custom_icon.dart';

class InfoViewBody extends StatefulWidget {
  InfoViewBody({super.key});

  @override
  State<InfoViewBody> createState() => _InfoViewBodyState();
}

class _InfoViewBodyState extends State<InfoViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: autovalidateMode,
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
              ),
              CustomIcon(),
              SizedBox(
                height: 16,
              ),
              Text(
                'Fill in your bio to get started',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'This data will be displayed in your account profile for security',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              CustomTextFormField(
                hint: 'First Name',
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                hint: 'Last Name',
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                hint: 'Phone Number',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              CustomButton(
                text: 'Next',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, OTPView.id);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

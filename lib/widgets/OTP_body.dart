import 'package:flutter/material.dart';
import 'package:food/widgets/OTP_field.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:food/widgets/custom_icon.dart';

class OTPViewBody extends StatelessWidget {
  const OTPViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SingleChildScrollView(
        child: Form(
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
                'Enter 4-digit Verification code',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Code sent to your Email. Check your inbox',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OTPField(
                      onSaved: (pin1) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                  OTPField(
                      onSaved: (pin2) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                  OTPField(
                      onSaved: (pin3) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                  OTPField(
                      onSaved: (pin4) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
              ),
              CustomButton(text: 'Next'),
            ],
          ),
        ),
      ),
    );
  }
}

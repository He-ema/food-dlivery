import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/views/enter_new_password.dart';
import 'package:food/widgets/OTP_field.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:food/widgets/custom_icon.dart';
import 'package:email_otp/email_otp.dart';

import '../constants.dart';

class OTPForgottenEmailBody extends StatefulWidget {
  const OTPForgottenEmailBody({super.key, required this.email});
  final String? email;
  @override
  State<OTPForgottenEmailBody> createState() => _OTPForgottenEmailBodyState();
}

class _OTPForgottenEmailBodyState extends State<OTPForgottenEmailBody> {
  EmailOTP myauth = EmailOTP();

  String otpValue = '';

  TextEditingController _controller = TextEditingController();

  TextEditingController _controller2 = TextEditingController();

  TextEditingController _controller3 = TextEditingController();

  TextEditingController _controller4 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myauth.setConfig(
        appEmail: "Food@gmail.com",
        appName: "Food",
        userEmail: widget.email,
        otpLength: 4,
        otpType: OTPType.digitsOnly);
    myauth.sendOTP();
  }

  CollectionReference users =
      FirebaseFirestore.instance.collection(kUseresCollectionReference);
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
              CustomIcon(
                icon: Icons.arrow_back_ios_new,
              ),
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
                      controller: _controller,
                      onSaved: (pin1) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                  OTPField(
                      controller: _controller2,
                      onSaved: (pin2) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                  OTPField(
                      controller: _controller3,
                      onSaved: (pin3) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                  OTPField(
                      controller: _controller4,
                      onSaved: (pin4) {},
                      onChanged: (value) async {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
              ),
              CustomButton(
                text: 'Next',
                onTap: () async {
                  otpValue += _controller.text;
                  otpValue += _controller2.text;
                  otpValue += _controller3.text;
                  otpValue += _controller4.text;
                  _controller.clear();
                  _controller2.clear();
                  _controller3.clear();
                  _controller4.clear();
                  await myauth.verifyOTP(otp: otpValue);

                  if (await myauth.verifyOTP(otp: otpValue) == true) {
                    Navigator.pushNamed(context, EnterNewPassword.id);
                  } else {
                    // ignore: use_build_context_synchronously
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: 'Warning',
                      desc: 'The code isn\'t true.',
                      btnOkColor: Theme.of(context).primaryColor,
                      btnOkOnPress: () {},
                    ).show();
                  }
                  otpValue = '';
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/cubit/auth_cubit_cubit.dart';
import 'package:food/views/email_created_congrats_view.dart';
import 'package:food/widgets/OTP_field.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:food/widgets/custom_icon.dart';
import 'package:email_otp/email_otp.dart';

import '../constants.dart';

class OTPViewBody extends StatefulWidget {
  OTPViewBody({super.key});
  @override
  State<OTPViewBody> createState() => _OTPViewBodyState();
}

class _OTPViewBodyState extends State<OTPViewBody> {
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
        userEmail: BlocProvider.of<AuthCubit>(context).ordinarySignInEmail,
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
                  User? user = FirebaseAuth.instance.currentUser;
                  if (await myauth.verifyOTP(otp: otpValue) == true) {
                    var doc = users.doc(BlocProvider.of<AuthCubit>(context)
                        .ordinarySignInEmail);
                    doc.update({
                      kState: kVerified,
                    });
                    Navigator.pushNamed(context, EmailCreatedCongratsView.id);
                  } else {
                    // ignore: use_build_context_synchronously
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: 'Warning',
                      desc: 'The code isn\'t true.',
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

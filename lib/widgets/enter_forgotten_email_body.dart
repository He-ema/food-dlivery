import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:food/widgets/custom_icon.dart';
import 'package:food/widgets/custom_text_form_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../views/OTP_forgot_email_view.dart';

class EnterForgottenEmailBody extends StatefulWidget {
  const EnterForgottenEmailBody({super.key});

  @override
  State<EnterForgottenEmailBody> createState() =>
      _EnterForgottenEmailBodyState();
}

class _EnterForgottenEmailBodyState extends State<EnterForgottenEmailBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  CollectionReference users =
      FirebaseFirestore.instance.collection(kUseresCollectionReference);
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
              'Forgot Password ?',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Enter Your Email address to reset your password',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 60,
            ),
            Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: CustomTextFormField(
                  hint: 'Email',
                  controller: _controller,
                )),
            Spacer(),
            CustomButton(
              text: 'Next',
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  isLoading = true;
                  setState(() {});
                  var doc = users.doc(_controller.text);
                  await doc.get().then((doc) {
                    if (doc.exists) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return OTPForgotEmail(
                          email: _controller.text,
                        );
                      }));
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.topSlide,
                        showCloseIcon: true,
                        title: 'Warning',
                        desc: 'User not found.',
                        btnOkOnPress: () {},
                        btnOkColor: Theme.of(context).primaryColor,
                      ).show();
                    }
                  });
                  isLoading = false;
                  setState(() {});
                } else {
                  autovalidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

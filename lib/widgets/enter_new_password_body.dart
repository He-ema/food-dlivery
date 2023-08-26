import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:food/widgets/custom_icon.dart';
import 'package:food/widgets/custom_text_form_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../views/OTP_forgot_email_view.dart';

class EnterNewPasswordBody extends StatefulWidget {
  const EnterNewPasswordBody({super.key});

  @override
  State<EnterNewPasswordBody> createState() => _EnterNewPasswordBodyState();
}

class _EnterNewPasswordBodyState extends State<EnterNewPasswordBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  CollectionReference users =
      FirebaseFirestore.instance.collection(kUseresCollectionReference);
  bool isLoading = false;
  bool isTypical = true;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
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
                'Reset password',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Enter your new password',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: 60,
              ),
              CustomTextFormField(
                hint: 'Enter the Password',
                controller: _controller,
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                hint: 'Enter the password again',
                controller: _controller2,
              ),
              SizedBox(
                height: 12,
              ),
              isTypical
                  ? Container()
                  : Center(
                      child: Text(
                        'The passwords isn\'t typical',
                        style: TextStyle(
                          color: Color(0xffd32f2f),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
              Spacer(),
              CustomButton(
                text: 'Next',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {});
                    if (_controller.text == _controller2.text && isTypical) {
                      isLoading = true;
                      setState(() {});
                      User? user = FirebaseAuth.instance.currentUser;
                      try {
                        await user?.updatePassword(_controller.text);
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: 'Done',
                          desc: 'Your password has been updated.',
                          btnOkColor: Theme.of(context).primaryColor,
                          btnOkOnPress: () {
                            Future.delayed(
                                Duration(milliseconds: 500),
                                () => {
                                      Navigator.pop(context),
                                      Navigator.pop(context),
                                      Navigator.pop(context),
                                    });
                          },
                        ).show();
                      } on Exception catch (e) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: 'Weak Password',
                          desc: 'The password provided is too weak.',
                          btnOkColor: Theme.of(context).primaryColor,
                          btnOkOnPress: () {},
                        ).show();
                      } catch (e) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: 'Error',
                          desc: 'Something went wrong try agan.',
                          btnOkColor: Theme.of(context).primaryColor,
                          btnOkOnPress: () {},
                        ).show();
                      }

                      //update code
                      isLoading = false;
                      setState(() {});
                    } else {
                      isTypical = false;
                    }
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

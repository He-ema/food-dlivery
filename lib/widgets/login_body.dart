import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/views/enter_email_forgotten.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../cubits/cubit/auth_cubit_cubit.dart';
import '../views/OTP_view.dart';
import '../views/home_view.dart';
import '../views/info_view.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';
import 'outside_register.dart';

class LoginBody extends StatefulWidget {
  LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  CollectionReference users =
      FirebaseFirestore.instance.collection(kUseresCollectionReference);
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String? email;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        email = BlocProvider.of<AuthCubit>(context).ordinaryLogInEmail;
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AuthCubitLoading ? true : false,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  autovalidateMode: autovalidateMode,
                  key: formKey,
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
                        'Login to your account',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      CustomTextFormField(
                        controller: _controller,
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
                        isPassword: true,
                        controller: _controller2,
                        hint: 'Password',
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, EnterForgottenEmail.id);
                        },
                        child: Text(
                          'Forgot your password ?',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      CustomButton(
                          text: 'Login',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await BlocProvider.of<AuthCubit>(context)
                                  .loginWithEmailAndPassword(
                                      email: _controller.text,
                                      password: _controller2.text,
                                      context: context);
                              if (BlocProvider.of<AuthCubit>(context)
                                      .ordinaryLogInEmail !=
                                  null) {
                                var doc = users.doc(_controller.text);
                                await doc.get().then((doc) {
                                  if (doc.exists) {
                                    var data = doc.data() as Map;
                                    if (data[kState] == kVerified) {
                                      Navigator.pushNamed(context, HomeView.id);
                                    } else {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                        title: 'Warning',
                                        desc:
                                            'You need to Verify Your account.',
                                        btnOkColor:
                                            Theme.of(context).primaryColor,
                                        btnOkOnPress: () {
                                          Future.delayed(
                                              Duration(milliseconds: 500),
                                              () => Navigator.pushNamed(
                                                  context, OTPView.id));
                                        },
                                      ).show();
                                    }
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.topSlide,
                                      showCloseIcon: true,
                                      title: 'Warning',
                                      btnOkColor:
                                          Theme.of(context).primaryColor,
                                      desc:
                                          'You need to continue setting your info.',
                                      btnOkOnPress: () {
                                        Future.delayed(
                                            Duration(milliseconds: 500),
                                            () => Navigator.pushNamed(
                                                context, OTPView.id));
                                      },
                                    ).show();
                                  }
                                });
                              }
                            } else {
                              autovalidateMode = AutovalidateMode.always;
                              setState(() {});
                            }
                          }),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Doesn\'t have an account ?',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                      ),
                      OutsideRegister(
                        onTap: () async {
                          await BlocProvider.of<AuthCubit>(context)
                              .signInWithGoogle();
                          if (BlocProvider.of<AuthCubit>(context).name !=
                              null) {
                            var doc = users
                                .doc(BlocProvider.of<AuthCubit>(context).email);
                            await doc.get().then((doc) {
                              if (doc.exists) {
                                Navigator.pushNamed(context, HomeView.id);
                              } else {
                                Navigator.pushNamed(context, InfoView.id);
                              }
                            });
                          }
                        },
                        image: 'assets/images/search.png',
                        text: 'Google',
                        color: Color.fromARGB(255, 46, 112, 167),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/cubit/auth_cubit_cubit.dart';
import 'package:food/views/info_view.dart';
import 'package:food/views/login_view.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'custom_text_form_field.dart';
import 'outside_register.dart';

class RegisterBody extends StatefulWidget {
  RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(
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
                        'Sign up for free',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
                      CustomButton(
                        text: 'Create account',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, InfoView.id);
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginView.id);
                        },
                        child: Text(
                          'Alraedy have an account ?',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      OutsideRegister(
                        onTap: () async {
                          await BlocProvider.of<AuthCubit>(context)
                              .signInWithGoogle();
                          if (BlocProvider.of<AuthCubit>(context).name !=
                              null) {
                            Navigator.pushNamed(context, InfoView.id);
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

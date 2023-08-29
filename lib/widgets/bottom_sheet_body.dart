import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:food/widgets/custom_text_form_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ButtomSheetBody extends StatefulWidget {
  const ButtomSheetBody({super.key});

  @override
  State<ButtomSheetBody> createState() => _ButtomSheetBodyState();
}

class _ButtomSheetBodyState extends State<ButtomSheetBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final GlobalKey<FormState> formKey = GlobalKey();
  bool isTypical = true;
  bool weakPassword = false;
  bool error = false;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Enter The New Password',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                    hint: 'New Password', controller: _controller),
                SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                    hint: 'New Password', controller: _controller2),
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
                weakPassword
                    ? Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Text(
                              'This password is too weak',
                              style: TextStyle(
                                color: Color(0xffd32f2f),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 12,
                ),
                CustomButton(
                  text: 'Save',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (_controller.text == _controller2.text) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        isLoading = true;
                        setState(() {});
                        User? user = FirebaseAuth.instance.currentUser;
                        try {
                          await user?.updatePassword(_controller.text);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Password Updated ',
                              textAlign: TextAlign.center,
                            ),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none),
                            margin: EdgeInsets.only(
                                bottom: 100, right: 10, left: 10),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Theme.of(context).primaryColor,
                          ));
                        } on Exception catch (e) {
                          weakPassword = true;
                          print(e);
                          setState(() {});
                        } catch (e) {
                          error = true;
                        }
                        isLoading = false;
                        setState(() {});
                      } else {
                        isTypical = false;
                        setState(() {});
                      }
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

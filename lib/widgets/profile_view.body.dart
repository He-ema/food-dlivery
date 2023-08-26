import 'package:flutter/material.dart';
import 'package:food/widgets/custom_text_form_field.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 55,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.25,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                Positioned(
                  bottom: 20,
                  right: 15,
                  child: CircleAvatar(
                    radius: 20,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextFormField(hint: 'First Name')),
                Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextFormField(hint: 'Second Name')),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextFormField(hint: 'Email'),
            SizedBox(
              height: 12,
            ),
            CustomTextFormField(hint: 'Phone'),
          ],
        ),
      ),
    );
  }
}

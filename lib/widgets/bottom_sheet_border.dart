import 'package:flutter/material.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:food/widgets/custom_text_form_field.dart';

class ButtomSheetBorder extends StatelessWidget {
  const ButtomSheetBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
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
                  'Enter The old Password',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextFormField(hint: 'Old Password'),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Enter The New Password',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextFormField(hint: 'New Password'),
            SizedBox(
              height: 12,
            ),
            CustomTextFormField(hint: 'New Password'),
            SizedBox(
              height: 12,
            ),
            CustomButton(
              text: 'Save',
              onTap: () {},
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}

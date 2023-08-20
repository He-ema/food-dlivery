import 'package:flutter/material.dart';
import 'package:food/views/home_view.dart';
import 'package:food/widgets/congratulations.dart';

class EmailCreatedCongratsView extends StatelessWidget {
  const EmailCreatedCongratsView({super.key});

  static String id = 'emailCreated';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Congratulations(
          text: Text(
            'Your Profile is ready to use ',
            style: TextStyle(fontSize: 18),
          ),
          onTap: () {
            Navigator.pushNamed(context, HomeView.id);
          }),
    );
  }
}

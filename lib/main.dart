import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food/constants.dart';
import 'package:food/views/login_view.dart';
import 'package:food/views/onboarding_view.dart';
import 'package:food/views/register_view.dart';
import 'package:food/views/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: KprimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        Splasher.id: (context) => Splasher(),
        RegisterView.id: (context) => RegisterView(),
        OnBoarding.id: (context) => OnBoarding(),
        LoginView.id: (context) => LoginView(),
      },
      initialRoute: Splasher.id,
    );
  }
}

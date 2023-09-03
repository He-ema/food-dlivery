import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/constants.dart';
import 'package:food/cubits/chat_cubit/chat_cubit.dart';
import 'package:food/simple_bloc_observer.dart';
import 'package:food/views/OTP_forgot_email_view.dart';
import 'package:food/views/OTP_view.dart';
import 'package:food/views/email_created_congrats_view.dart';
import 'package:food/views/enter_email_forgotten.dart';
import 'package:food/views/enter_new_password.dart';
import 'package:food/views/bottom_nav_bar_view.dart';
import 'package:food/views/info_view.dart';
import 'package:food/views/login_view.dart';
import 'package:food/views/onboarding_view.dart';
import 'package:food/views/register_view.dart';
import 'package:food/views/splash_view.dart';

import 'cubits/auth_cubit/auth_cubit_cubit.dart';
import 'cubits/cart_cubit/cart_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: KprimaryColor,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          Splasher.id: (context) => Splasher(),
          RegisterView.id: (context) => RegisterView(),
          OnBoarding.id: (context) => OnBoarding(),
          LoginView.id: (context) => LoginView(),
          InfoView.id: (context) => InfoView(),
          OTPView.id: (context) => OTPView(),
          EmailCreatedCongratsView.id: (context) => EmailCreatedCongratsView(),
          BottomNavigationBarView.id: (context) => BottomNavigationBarView(),
          EnterForgottenEmail.id: (context) => EnterForgottenEmail(),
          OTPForgotEmail.id: (context) => OTPForgotEmail(),
          EnterNewPassword.id: (context) => EnterNewPassword(),
        },
        initialRoute: Splasher.id,
      ),
    );
  }
}

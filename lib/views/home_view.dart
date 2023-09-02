import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/chat_cubit/chat_cubit.dart';
import 'package:food/widgets/onboarding_stack.dart';

import '../cubits/auth_cubit/auth_cubit_cubit.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ChatCubit>(context).currentEmail =
        BlocProvider.of<AuthCubit>(context).currentEmail;

    BlocProvider.of<AuthCubit>(context)
        .getAuthData(email: BlocProvider.of<AuthCubit>(context).currentEmail!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(
        stackView: HomeViewBody(),
        isBig: false,
      ),
    );
  }
}

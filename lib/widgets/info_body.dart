import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/cubit/auth_cubit_cubit.dart';
import 'package:food/views/OTP_view.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:food/widgets/custom_text_form_field.dart';

import '../views/email_created_congrats_view.dart';
import 'custom_icon.dart';

class InfoViewBody extends StatefulWidget {
  InfoViewBody({super.key});
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  @override
  State<InfoViewBody> createState() => _InfoViewBodyState();
}

class _InfoViewBodyState extends State<InfoViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (BlocProvider.of<AuthCubit>(context).name != null) {
      List<String> name = splitName();
      widget._controller.text = name[0];
      widget._controller2.text = name[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: autovalidateMode,
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
              ),
              CustomIcon(),
              SizedBox(
                height: 16,
              ),
              Text(
                'Fill in your bio to get started',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'This data will be displayed in your account profile for security',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              CustomTextFormField(
                controller: widget._controller,
                hint: 'First Name',
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                controller: widget._controller2,
                hint: 'Last Name',
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                hint: 'Phone Number',
                controller: widget._controller3,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              CustomButton(
                text: 'Next',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<AuthCubit>(context).createUser(
                        firstName: widget._controller.text,
                        secondName: widget._controller2.text,
                        phone: widget._controller3.text,
                        email: BlocProvider.of<AuthCubit>(context).email!);
                    Navigator.pushNamed(context, EmailCreatedCongratsView.id);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> splitName() {
    String text = '';
    List<String> name = [];
    for (int i = 0; i < BlocProvider.of<AuthCubit>(context).name!.length; i++) {
      if (BlocProvider.of<AuthCubit>(context).name![i] == ' ' ||
          i == BlocProvider.of<AuthCubit>(context).name!.length - 1) {
        text += BlocProvider.of<AuthCubit>(context).name![i];
        name.add(text);
        text = '';
      } else {
        text += BlocProvider.of<AuthCubit>(context).name![i];
      }
    }
    return name;
  }
}

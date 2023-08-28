import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/constants.dart';
import 'package:food/cubits/cubit/auth_cubit_cubit.dart';
import 'package:food/widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ProfileViewBody extends StatefulWidget {
  ProfileViewBody({super.key, this.onTap});
  void Function()? onTap;
  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final TextEditingController _controller = TextEditingController();

  final TextEditingController _controller2 = TextEditingController();

  final TextEditingController _controller3 = TextEditingController();

  final TextEditingController _controller4 = TextEditingController();

  void setData() {
    _controller.text = BlocProvider.of<AuthCubit>(context).info![kFirstName];
    _controller2.text = BlocProvider.of<AuthCubit>(context).info![kSecondName];
    _controller3.text = BlocProvider.of<AuthCubit>(context).info![kEmail];
    _controller4.text = BlocProvider.of<AuthCubit>(context).info![kPhone];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      backgroundColor: Colors.white,
      color: Theme.of(context).primaryColor.withOpacity(0.5),
      onRefresh: () async {
        if (BlocProvider.of<AuthCubit>(context).email != null) {
          await BlocProvider.of<AuthCubit>(context)
              .getAuthData(email: BlocProvider.of<AuthCubit>(context).email!);
        } else if (BlocProvider.of<AuthCubit>(context).ordinaryLogInEmail !=
            null) {
          await BlocProvider.of<AuthCubit>(context).getAuthData(
              email: BlocProvider.of<AuthCubit>(context).ordinaryLogInEmail!);
        } else {
          await BlocProvider.of<AuthCubit>(context).getAuthData(
              email: BlocProvider.of<AuthCubit>(context).ordinarySignInEmail!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
                    child: GestureDetector(
                      onTap: () {
                        openDialog();
                      },
                      child: CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                        ),
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
                      child: CustomTextFormField(
                        hint: 'First Name',
                        controller: _controller,
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomTextFormField(
                        hint: 'Second Name',
                        controller: _controller2,
                      )),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'This field can\'t be edited ',
                        textAlign: TextAlign.center,
                      ),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      margin: EdgeInsets.only(bottom: 100, right: 10, left: 10),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                },
                child: CustomTextFormField(
                  enabled: false,
                  hint: 'Email',
                  controller: _controller3,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                hint: 'Phone',
                controller: _controller4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pickImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  void pickImageFromCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
  }

  void openDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: pickImageFromCamera,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/camera.png'),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Take a photo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: pickImageFromGallery,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/Gallery.png'),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'From Gallery',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

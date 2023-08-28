import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/constants.dart';
import 'package:food/cubits/cubit/auth_cubit_cubit.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:food/widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'bottom_sheet_border.dart';

class ProfileViewBody extends StatefulWidget {
  ProfileViewBody({super.key, this.onTap});
  void Function()? onTap;
  String? uniqueName;

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

  CollectionReference users =
      FirebaseFirestore.instance.collection(kUseresCollectionReference);
  String? imageUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
    widget.uniqueName = BlocProvider.of<AuthCubit>(context).currentEmail!;
  }

  String? filePath;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: LiquidPullToRefresh(
            backgroundColor: Colors.white,
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            onRefresh: () async {
              setState(() {});
              await BlocProvider.of<AuthCubit>(context).getAuthData(
                  email: BlocProvider.of<AuthCubit>(context).currentEmail!);
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
                        BlocProvider.of<AuthCubit>(context).info![kImage] ==
                                null
                            ? CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.25,
                                backgroundColor: Theme.of(context).primaryColor,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
                              )
                            : CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.25,
                                backgroundColor: Theme.of(context).primaryColor,
                                backgroundImage: NetworkImage(
                                    BlocProvider.of<AuthCubit>(context)
                                        .info![kImage]),
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
                            margin: EdgeInsets.only(
                                bottom: 100, right: 10, left: 10),
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
                    SizedBox(
                      height: 12,
                    ),
                    CustomButton(
                      text: 'Change password',
                      onTap: () {
                        showBottomSheet(
                          enableDrag: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          context: context,
                          builder: (context) => ButtomSheetBorder(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> pickImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    Navigator.pop(context);
    if (image != null) {
      filePath = image.path;
      await uploadImage(imagePath: filePath!);
    }
  }

  Future<void> pickImageFromCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    Navigator.pop(context);
    if (image != null) {
      filePath = image.path;
      await uploadImage(imagePath: filePath!);
    }
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
                onTap: () async {
                  await pickImageFromCamera();
                },
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
                onTap: () async {
                  await pickImageFromGallery();
                },
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

  Future<void> uploadImage({required String imagePath}) async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');
    Reference referenceUploadedImage = referenceDirImage
        .child(BlocProvider.of<AuthCubit>(context).currentEmail! + 'image');

    try {
      isLoading = true;
      setState(() {});
      await referenceUploadedImage.putFile(File(imagePath));
      imageUrl = await referenceUploadedImage.getDownloadURL();
      // this line above to get the url of the uploaded file
      await users
          .doc(BlocProvider.of<AuthCubit>(context).currentEmail!)
          .update({
        kImage: imageUrl,
      });
      isLoading = false;
      setState(() {});
      await BlocProvider.of<AuthCubit>(context).getAuthData(
          email: BlocProvider.of<AuthCubit>(context).currentEmail!);
      setState(() {});
    } catch (error) {
      print(error);
    }
  }
}

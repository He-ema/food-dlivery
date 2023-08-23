import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial());
  String? name;
  String? email;
  String? ordinarySignInEmail;
  String? ordinaryLogInEmail;
  CollectionReference users =
      FirebaseFirestore.instance.collection(kUseresCollectionReference);
  dynamic signInWithGoogle() async {
    emit(AuthCubitLoading());
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      emit(AuthCubitSuccess());
      name = googleUser!.displayName;
      email = googleUser.email;

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
      emit(AuthCubitFailure());
    }
  }

  void createUser(
      {required String firstName,
      required String secondName,
      required String phone,
      required String email,
      required String state}) {
    emit(AuthCubitLoading());
    try {
      users.doc(email).set({
        kFirstName: firstName,
        kSecondName: secondName,
        kPhone: phone,
        kEmail: email,
        kState: state
      });
      emit(AuthCubitSuccess());
    } catch (e) {
      emit(AuthCubitFailure());
    }
  }

  Future<void> registerWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(AuthCubitLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      ordinarySignInEmail = email;
      emit(AuthCubitSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthCubitFailure());
      if (e.code == 'weak-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: 'Weak Password',
          desc: 'The password provided is too weak.',
          btnOkOnPress: () {},
        ).show();
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: 'Email Exist',
          desc: 'The account already exists for that email.',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      emit(AuthCubitFailure());
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: 'Error',
        desc: 'Something went wrong try again.',
        btnOkOnPress: () {},
      ).show();
    }
  }

  Future<void> loginWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(AuthCubitLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ordinaryLogInEmail = email;
      emit(AuthCubitSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthCubitFailure());
      if (e.code == 'user-not-found') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: 'User not found',
          desc: 'The email you entered isn\'t found.',
          btnOkOnPress: () {},
        ).show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: 'Wrong Password',
          desc: 'The Password you entered is wrong.',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      emit(AuthCubitFailure());
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: 'Error',
        desc: 'Something went wrong try again.',
        btnOkOnPress: () {},
      ).show();
    }
  }
}

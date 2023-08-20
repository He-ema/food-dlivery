import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial());
  String? name;
  String? email;
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
      required String email}) {
    users.doc(email).set({
      kFirstName: firstName,
      kSecondName: secondName,
      kPhone: phone,
      kEmail: email,
    });
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/helper/user/db_helper.dart';
import 'package:riverpod_todo/common/utils/core_utils.dart';
import 'package:riverpod_todo/features/auth/authentication/views/otp_verification_screen.dart';
import 'package:riverpod_todo/features/todo/pages/homepage.dart';


final authRepoProvider = Provider((ref) => AuthenticationRepository(auth: FirebaseAuth.instance));

class AuthenticationRepository {
  const AuthenticationRepository({
    required this.auth,
  });

  final FirebaseAuth auth;

  Future<void> sendOTP({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) {
        auth.signInWithCredential(credential);
      },
      verificationFailed: (exception) {
        CoreUtils.showSnackBar(
          context: context,
          message: '${exception.code} : ${exception.message}',
        );
      },
      codeSent: (verificationId, _) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>  OTPVerificationScreen(
                verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<void> verifyOTP({
    required BuildContext context,
    required final String verificationId,
    required final String otp,
  }) async {
    void showSnack(message) =>
        CoreUtils.showSnackBar(context: context, message: message);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final navigator = Navigator.of(context);
      final userCredential = await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await DBHelper.createUser(isVerified: true);
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const HomePage()
          ),
              (route) => false,
        );
      } else {
        showSnack('Error Occurred, Failed to Sign Up User');
      }
    } on FirebaseException catch (e) {
      CoreUtils.showSnackBar(
        context: context,
        message: '${e.code} : ${e.message}',
      );
    }
    catch(e){
      CoreUtils.showSnackBar(
        context: context,
        message: '505 : Error occurred failed to Sign up',
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:riverpod_todo/common/res/colors.dart';
import 'package:riverpod_todo/common/res/image_res.dart';
import 'package:riverpod_todo/common/utils/core_utils.dart';
import 'package:riverpod_todo/common/widgets/white_space.dart';
import 'package:riverpod_todo/features/auth/authentication/controller/authentication_controller.dart';


class OTPVerificationScreen extends ConsumerWidget {
  const OTPVerificationScreen({required this.verificationId, super.key});

  final String verificationId;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageRes.todo),
                const WhiteSpace(height: 26),
                 Pinput(
                  length: 6,
                  onCompleted: (pin) async {
                    CoreUtils.showLoader(context);
                    await ref.read(authControllerProvider).verifyOTP(
                        context: context,
                        verificationId: verificationId, otp: pin);
                  },
                   defaultPinTheme:  PinTheme(
                     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                     decoration: BoxDecoration(
                       color: Colours.light,
                       borderRadius: BorderRadius.circular(8),
                     )
                   ),
                )
              ],
            ),
          )
      ),
    );
  }
}

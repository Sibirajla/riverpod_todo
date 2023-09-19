import 'package:flutter/material.dart';
import 'package:riverpod_todo/common/res/image_res.dart';
import 'package:riverpod_todo/common/widgets/white_space.dart';
import 'package:riverpod_todo/features/onboarding/widgets/pageone.dart';
import 'package:riverpod_todo/features/onboarding/widgets/round_button.dart';


class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //image
          Image.asset(ImageRes.todo),
          const WhiteSpace(height: 50),
          RoundButton(
            text: 'Login with phone',
            onPressed: (){

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SignInScreen()));
            },
          )
        ],
      ),
    );
  }
}

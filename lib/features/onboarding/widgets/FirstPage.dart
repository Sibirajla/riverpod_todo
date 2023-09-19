import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_todo/common/res/colors.dart';
import 'package:riverpod_todo/common/res/image_res.dart';
import 'package:riverpod_todo/common/widgets/fadding_text.dart';
import 'package:riverpod_todo/common/widgets/white_space.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //image
          Image.asset(ImageRes.todo),
          const WhiteSpace(height: 100),
          //title Text
          const FadingText(
            'ToDo with Riverpod',
            textAlign: TextAlign.center,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
          const WhiteSpace(height: 10),
          //body Text
          Text(
            'Welcome!!! Do you want to clear tasks super fast with ToDo?',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colours.lightGrey
            ),
          ),
        ],
      ),
    );
  }
}

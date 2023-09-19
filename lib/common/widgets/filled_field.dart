import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/colors.dart';

class FilledField extends ConsumerWidget {
  const FilledField({this.hintStyle, this.controller,  this.readOnly = false, this.prefixIcon, this.suffixIcon, this.hintText, this.keyboardType, super.key});

  final TextEditingController? controller;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final border = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(16.h));
    return TextField(
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(
          fontSize: 18,
          color: Colours.darkBackground,
          fontWeight: FontWeight.bold),
      controller: controller,
      readOnly: readOnly,
      onTapOutside: (_){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colours.light,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
        suffix: suffixIcon,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        focusedBorder: border,
        enabledBorder: border,
      ),
    );
  }
}

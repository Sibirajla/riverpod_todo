
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_todo/common/utils/constants.dart';

class FadingText extends StatelessWidget {
  const FadingText(
      this.text,
      {
        this.fontSize,
        this.fontWeight,
        this.colour,
        this.textAlign,
        this.overflow,
        super.key, this.maxLines, this.letterSpacing, this.height
      });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? colour;
  final TextAlign?textAlign;
  final TextOverflow? overflow;
  final int?maxLines;
  final double?letterSpacing;
  final double?height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      softWrap: false,
      overflow: overflow ?? TextOverflow.fade,
      textAlign: textAlign ?? TextAlign.left,

      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: colour ?? AppConst.kLight,
        letterSpacing: letterSpacing, // Adjust letter spacing as needed
        height: height,
      ),

    );
  }
}

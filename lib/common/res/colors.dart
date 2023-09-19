import 'dart:math';
import 'dart:ui';

class Colours {
  const Colours._();

  static const Color darkBackground = Color(0xFF2a2b2e);
  static const Color light = Color(0xFFFFFFFF);
  static const Color red = Color(0xffd80000);
  static const Color lightBlue = Color(0xFF027EB5);
  static const Color darkGrey = Color(0xFF707070);
  static const Color lightGrey = Color(0xFF667781);
  static const Color green = Color(0xFF0AA31E);
  static const Color yellow = Color(0xFFF9F900);
  static const Color lightBackground = Color(0x58797777);
  static const Color greyBackground = Color(0xFF202C33);


  static const colours = [
    Color(0xffd80000),
    Color(0xFF027EB5),
    Color(0xFFF50FCF),
    Color(0xFFAC0FF5),
    Color(0xFF0AA31E),
    Color(0xFFF9F900),

  ];


  static Color randomColour()
  {
    final random = Random();
    int randomIndex = random.nextInt(Colours.colours.length);
    return Colours.colours[randomIndex];
  }
}
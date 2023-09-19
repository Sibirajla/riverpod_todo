import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhiteSpace extends StatelessWidget{
  const WhiteSpace({this.height,this.width,super.key});

  final double? height;
  final double? width;


  @override
  Widget build(BuildContext context){
    return  SizedBox(height: height?.h,width: width?.h);
  }
}
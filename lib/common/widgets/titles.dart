import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:riverpod_todo/common/widgets/appstyle.dart';
import 'package:riverpod_todo/common/widgets/hight_spacer.dart';
import 'package:riverpod_todo/common/widgets/reusable_text.dart';
import 'package:riverpod_todo/features/todo/controllers/todo_provider.dart';

class BottomTiles extends StatelessWidget {
  const BottomTiles({super.key, required this.text, required this.text2,  this.clr});

  final String text;
  final String text2;
  final Color? clr;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.kWidth,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(builder: (context, ref, child) {
             var color = ref.read(todoStateProvider.notifier).getRandomColor();
              return Container(
                height: 80.h,
                width: 5.w,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppConst.kRadius)),
                  color: color,
                ),
              );
            }),
            HeightSpacer(width: 15.h),
            Padding(
                padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReUsableText(
                      text: text,
                      style: appstyle(24, AppConst.kLight, FontWeight.bold)
                  ),

                  HeightSpacer(height: 10.h),
                  ReUsableText(
                      text: text2,
                      style: appstyle(12, AppConst.kLight, FontWeight.normal)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

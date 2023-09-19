import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:riverpod_todo/common/widgets/appstyle.dart';
import 'package:riverpod_todo/common/widgets/hight_spacer.dart';
import 'package:riverpod_todo/common/widgets/reusable_text.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, this.color, this.title,  this.description, this.start, this.end, this.editWidget, this.delete, this.switcher});
  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final Widget? switcher;
  final void Function()? delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            width: AppConst.kWidth,
            decoration: BoxDecoration(
              color: AppConst.kGreyLight,
              borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80.h,
                      width: 5.w,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppConst.kRadius)),
                        //TODO: ADD DYNAMIC COLORS
                        color: color ?? AppConst.kGreen,
                      ),
                    ),
                    HeightSpacer(width: 15.w),
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: SizedBox(
                        width: AppConst.kWidth*0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReUsableText(
                                text: title ?? "Title of Todo",
                                style: appstyle(
                                    18, AppConst.kLight, FontWeight.bold)),
                            HeightSpacer(height: 3.h),
                            ReUsableText(
                                text: description ?? "Description of Todo",
                                style: appstyle(
                                    18, AppConst.kLight, FontWeight.bold)),
                            HeightSpacer(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: AppConst.kWidth*0.3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    color: AppConst.kBkDark,
                                    border: Border.all(
                                      width: 0.3.w,
                                      color: AppConst.kGreyDk,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius))
                                  ),
                                  child: Center(
                                    child: ReUsableText(
                                      text: "$start | $end",
                                      style: appstyle(12, AppConst.kLight, FontWeight.normal),
                                    ),
                                  ),
                                ),
                                HeightSpacer(width: 20.w),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editWidget,
                                    ),
                                    HeightSpacer(width: 20.w),
                                    GestureDetector(
                                      onTap: delete,
                                      child: const Icon(MaterialCommunityIcons.delete_circle),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 0.h),
                  child: switcher,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

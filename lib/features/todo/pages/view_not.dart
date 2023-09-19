import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_todo/common/res/image_res.dart';
import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:riverpod_todo/common/widgets/appstyle.dart';
import 'package:riverpod_todo/common/widgets/hight_spacer.dart';
import 'package:riverpod_todo/common/widgets/reusable_text.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key, this.payload});

  final String? payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Container(
                width: AppConst.kWidth,
                height: AppConst.kHeight * 0.7,
                decoration: BoxDecoration(
                    color: AppConst.kBkLight,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppConst.kRadius))),
                child: Padding(
                  padding: EdgeInsets.all(12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReUsableText(
                          text: "Remainder",
                          style:
                              appstyle(40, AppConst.kLight, FontWeight.bold)),
                      HeightSpacer(height: 5.h),
                      Container(
                        width: AppConst.kWidth,
                        padding: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          color: AppConst.kYellow,
                          borderRadius: BorderRadius.all(Radius.circular(9.h)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReUsableText(
                              text: "Today",
                              style: appstyle(
                                  14, AppConst.kBkDark, FontWeight.bold),
                            ),
                            HeightSpacer(width: 15.h),
                            ReUsableText(
                              text: "From : start To : end",
                              style: appstyle(
                                  15, AppConst.kBkDark, FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      HeightSpacer(height: 10.h),
                      ReUsableText(
                        text: "Tittle",
                        style: appstyle(30, AppConst.kBkDark, FontWeight.bold),
                      ),
                      HeightSpacer(height: 10.h),
                      Text(
                        "desc Tittle hsadhjsdhjsgdh sdsghdhsgd",
                        maxLines: 8,
                        textAlign: TextAlign.justify,
                        style: appstyle(16, AppConst.kLight, FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                right: 12.w,
                top: -10,
                child: Image.asset(
                  ImageRes.bell,
                  width: 70.w,
                  height: 70.h,
                )),
            Positioned(
                bottom: -AppConst.kHeight * 0.143,
                left: 0,
                right: 0,
                child: Image.asset(
                  ImageRes.notification,
                  width: AppConst.kWidth*0.8,
                  height: AppConst.kHeight*0.6,
                ))
          ],
        ),
      ),
    );
  }
}

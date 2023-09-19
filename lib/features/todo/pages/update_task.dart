import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:riverpod_todo/common/widgets/appstyle.dart';
import 'package:riverpod_todo/common/widgets/custom_otn_btn.dart';
import 'package:riverpod_todo/common/widgets/custom_text.dart';
import 'package:riverpod_todo/common/widgets/hight_spacer.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:riverpod_todo/common/widgets/show_dialogue.dart';
import 'package:riverpod_todo/features/todo/controllers/dates/dates_provider.dart';
import 'package:riverpod_todo/features/todo/controllers/todo_provider.dart';

class UpdateTask extends ConsumerStatefulWidget {
  const UpdateTask({required this.id, super.key});

  final int id;

  @override
  ConsumerState createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<UpdateTask> {
  final TextEditingController title = TextEditingController(text: titles);
  final TextEditingController desc = TextEditingController(text: descs);
  @override
  Widget build(BuildContext context) {
    var scheduleDate = ref.watch(dateStateProvider);
    var start = ref.watch(startTimeStateProvider);
    var finish = ref.watch(finishTimeStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            HeightSpacer(height: 20.h),
            CustomTextField(
              hintText: "Add Title",
              controller: title,
              hintStyle: appstyle(16, AppConst.kGreyLight, FontWeight.w600),
            ),
            HeightSpacer(height: 20.h),
            CustomTextField(
              hintText: "Add description",
              controller: desc,
              hintStyle: appstyle(16, AppConst.kGreyLight, FontWeight.w600),
            ),
            HeightSpacer(height: 20.h),
            CustomOtlBtn(
                onTap: () {
                  picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(DateTime.now().year + 1),
                      theme: const picker.DatePickerTheme(
                          doneStyle:
                              TextStyle(color: AppConst.kGreen, fontSize: 16)),
                      onConfirm: (date) {
                    ref.read(dateStateProvider.notifier).setDate(date.toString());
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                },
                width: AppConst.kWidth,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kBlueLight,
                text: scheduleDate=="" ? "Set Date" : scheduleDate.substring(0,10)),
            HeightSpacer(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOtlBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(DateTime.now().year + 1),
                          onConfirm: (date) {
                        ref.read(startTimeStateProvider.notifier).setStart(date.toString());
                          },
                          locale: picker.LocaleType.en);
                    },
                    width: AppConst.kWidth * 0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text: start == "" ? "Start Time" : start.substring(10,16)
                ),
                CustomOtlBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(DateTime.now().year + 1),
                          onConfirm: (date) {
                            ref.read(finishTimeStateProvider.notifier).setStart(date.toString());
                          },
                          locale: picker.LocaleType.en);
                    },
                    width: AppConst.kWidth * 0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text: finish == "" ? "End Time" : finish.substring(10,16)
                ),
              ],
            ),
            HeightSpacer(height: 20.h),

            CustomOtlBtn(
                onTap: () {
                  if(
                    title.text.isNotEmpty &&
                        desc.text.isNotEmpty &&
                        scheduleDate.isNotEmpty &&
                        start.isNotEmpty &&
                        finish.isNotEmpty
                  )
                    {
                      ref.read(todoStateProvider.notifier).updateItem(
                          widget.id,
                          title.text,
                          desc.text,
                           0,
                          scheduleDate,
                          start.substring(10,16),
                          finish.substring(10,16),
                           );
                      ref.read(dateStateProvider.notifier).setDate('');
                      ref.read(startTimeStateProvider.notifier).setStart('');
                      ref.read(finishTimeStateProvider.notifier).setStart('');
                      Navigator.pop(context);
                    }
                  else{
                    showAlertDialog(
                        context: context,
                        message: 'Failed to Add Task'
                    );
                  }
                },
                width: AppConst.kWidth,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kGreen,
                text: "Submit"
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/helper/notification_helper.dart';
import 'package:riverpod_todo/common/models/task_model.dart';
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
import 'package:riverpod_todo/features/todo/pages/homepage.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();

  List<int>notifications = [];

  late NotificationsHelper controller;
  late NotificationsHelper notifyHelper;
  final TextEditingController search = TextEditingController();




  @override
  void initState(){
    notifyHelper = NotificationsHelper(ref: ref);
    Future.delayed(const Duration(seconds: 0), () {
      controller = NotificationsHelper(ref: ref);
    });
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    super.initState();
  }

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
                        notifications = ref.read(startTimeStateProvider.notifier).dates(date);
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
                      Task task = Task(
                        title: title.text,
                        desc: desc.text,
                        isCompleted : 0,
                        date: scheduleDate,
                        startTime: start.substring(10,16),
                        endTime: finish.substring(10,16),
                        remind: 0,
                        repeat: "yes"
                      );
                      notifyHelper.scheduledNotification(
                          notifications[0],
                          notifications[1],
                          notifications[2],
                          notifications[3],
                        task
                      );
                      ref.read(todoStateProvider.notifier).addItem(task);
                      //ref.read(dateStateProvider.notifier).setDate('');
                      //ref.read(startTimeStateProvider.notifier).setStart('');
                      //ref.read(finishTimeStateProvider.notifier).setStart('');
                      Navigator.push(context, MaterialPageRoute(builder:
                      (context) => const HomePage()
                      ));
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

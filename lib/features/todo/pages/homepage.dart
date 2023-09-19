import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/helper/notification_helper.dart';
import 'package:riverpod_todo/common/helper/user/db_helper.dart';
import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:riverpod_todo/common/widgets/appstyle.dart';
import 'package:riverpod_todo/common/widgets/custom_text.dart';
import 'package:riverpod_todo/common/widgets/hight_spacer.dart';
import 'package:riverpod_todo/common/widgets/reusable_text.dart';
import 'package:riverpod_todo/features/auth/authentication/views/sign_in_screen.dart';
import 'package:riverpod_todo/features/todo/controllers/todo_provider.dart';
import 'package:riverpod_todo/features/todo/pages/add.dart';
import 'package:riverpod_todo/features/todo/widgets/completed_task.dart';
import 'package:riverpod_todo/features/todo/widgets/dayAfter_tomorrow.dart';
import 'package:riverpod_todo/features/todo/widgets/today_task.dart';
import 'package:riverpod_todo/features/todo/widgets/tomorrow_list.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);
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
    ref.watch(todoStateProvider.notifier).refresh();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: const BoxDecoration(
                        color: AppConst.kLight,
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          final navigator = Navigator.of(context);
                          await DBHelper.deleteUser();
                          navigator.pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => const SignInScreen(),
                            ),
                                (route) => false,
                          );
                        },
                        child: const Icon(
                          AntDesign.logout,
                          color: AppConst.kBkDark,
                        ),
                      ),
                    ),
                    ReUsableText(
                        text: "DashBoard",
                        style: appstyle(18, AppConst.kLight, FontWeight.bold)),
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: const BoxDecoration(
                        color: AppConst.kLight,
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddTask()));
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppConst.kBkDark,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              HeightSpacer(height: 20.h),
              CustomTextField(
                hintText: "Search",
                controller: search,
                prefixIcon: Container(
                  padding: EdgeInsets.all(14.h),
                  child: GestureDetector(
                    onTap: null,
                    child: const Icon(
                      AntDesign.search1,
                      color: AppConst.kGreyLight,
                    ),
                  ),
                ),
                suffixIcon: const Icon(
                  FontAwesome.sliders,
                  color: AppConst.kGreyLight,
                ),
              ),
              HeightSpacer(height: 15.h),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            HeightSpacer(height: 25.h),
            Row(
              children: [
                const Icon(FontAwesome.tasks, size: 20, color: AppConst.kLight),
                HeightSpacer(width: 10.w),
                ReUsableText(
                    text: "Today's Task",
                    style: appstyle(18, AppConst.kLight, FontWeight.bold)),
              ],
            ),
            HeightSpacer(height: 25.h),
            Container(
              decoration: BoxDecoration(
                color: AppConst.kLight,
                borderRadius:
                    BorderRadius.all(Radius.circular(AppConst.kRadius)),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    color: AppConst.kGreyLight,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppConst.kRadius))),
                controller: tabController,
                labelPadding: EdgeInsets.zero,
                isScrollable: false,
                labelColor: AppConst.kBlueLight,
                labelStyle: appstyle(24, AppConst.kBlueLight, FontWeight.w700),
                unselectedLabelColor: AppConst.kLight,
                tabs: [
                  Tab(
                    child: SizedBox(
                      width: AppConst.kWidth * 0.5,
                      child: Center(
                        child: ReUsableText(
                          text: "Pending",
                          style:
                              appstyle(16, AppConst.kBkDark, FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.only(left: 30.w),
                      width: AppConst.kWidth * 0.5,
                      child: Center(
                        child: ReUsableText(
                          text: "Completed",
                          style:
                              appstyle(16, AppConst.kBkDark, FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HeightSpacer(height: 20.h),
            SizedBox(
              height: AppConst.kHeight * 0.3,
              width: AppConst.kWidth,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppConst.kRadius)),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Container(
                      color: AppConst.kBkLight,
                      height: AppConst.kHeight * 0.3,
                      child: const TodayTask(),
                    ),
                    Container(
                      color: AppConst.kBkLight,
                      height: AppConst.kHeight * 0.3,
                      child: const CompletedTask(),
                    ),
                  ],
                ),
              ),
            ),
            HeightSpacer(height: 20.h),
            const TomorrowList(),
            HeightSpacer(height: 20.h),
            const DayAfterTomorrow()
          ],
        ),
      )),
    );
  }
}

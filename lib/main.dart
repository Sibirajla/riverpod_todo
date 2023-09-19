import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_todo/common/res/colors.dart';
import 'package:riverpod_todo/features/auth/authentication/app/user_provider.dart';
import 'package:riverpod_todo/features/onboarding/pages/onboarding.dart';
import 'package:riverpod_todo/features/todo/pages/homepage.dart';
import 'package:riverpod_todo/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: screenSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        // do stuff here
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
            scaffoldBackgroundColor: Colours.darkBackground,
            useMaterial3: true,
          ),
          home: ref.watch(userProvider).when(data: (userExists) {
            if (userExists) return const HomePage();
            return const OnBoardingScreen();
          }, error: (error, stackTrace) {
            debugPrint('ERROR: $error');
            debugPrint(stackTrace.toString());
            return const OnBoardingScreen();
          }, loading: () {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
        );
      },
    );
  }
}

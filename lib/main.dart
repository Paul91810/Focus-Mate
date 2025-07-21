import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/theme/theme.dart';
import 'package:focus_mate/data/models/profile_model.dart';
import 'package:focus_mate/data/notifications/notifications.dart';
import 'package:focus_mate/presentation/splash/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await ScreenUtil.ensureScreenSize();
  await Hive.initFlutter();
  await NotificationService().initNotification();
  await NotificationService().requestNotificationPermission();
  await Hive.openBox('pomodoro_timer');
  await Hive.openBox('User_id');
  Hive.registerAdapter(GetProfileAdapter());
  await Hive.openBox('profileBox');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheame.darkTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}

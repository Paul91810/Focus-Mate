import 'package:hive/hive.dart';

class AppHiveBox {
  static final Box pomodoroBox = Hive.box('pomodoro_timer');
  static final Box userBox = Hive.box('User_id');
  static final Box profileBox = Hive.box('profileBox');
}

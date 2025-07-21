import 'package:hive/hive.dart';

class HiveBoxs {
 static final Box pomodoroBox = Hive.box('pomodoro_timer');
 static final Box userBox = Hive.box('User_id');
}
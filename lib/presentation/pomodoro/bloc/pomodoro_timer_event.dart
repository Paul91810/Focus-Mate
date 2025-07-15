part of 'pomodoro_timer_bloc.dart';

@immutable
sealed class PomodoroTimerEvent {}

class StartTimer extends PomodoroTimerEvent {}

class PauseTimer extends PomodoroTimerEvent {}

class ResetTimer extends PomodoroTimerEvent {}

class GetInvertedPercentage extends PomodoroTimerEvent {}

class Tick extends PomodoroTimerEvent {}

class SetWorkTime extends PomodoroTimerEvent {
  final int minutes;
  SetWorkTime(this.minutes);
}

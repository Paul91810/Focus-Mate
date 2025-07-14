part of 'pomodoro_timer_bloc.dart';

@immutable
sealed class PomodoroTimerState {}

class PomodoroTimerInitial extends PomodoroTimerState {
  final int workTimeInMinutes;
  final int remainingSeconds;
  final bool isRunning;
  PomodoroTimerInitial({
    required this.workTimeInMinutes,
    required this.remainingSeconds,
    required this.isRunning,
  });
  PomodoroTimerInitial copyWith({
    int? workTimeInMinutes,
    int? remainingSeconds,
    bool? isRunning,
  }) {
    return PomodoroTimerInitial(
      workTimeInMinutes: workTimeInMinutes ?? this.workTimeInMinutes,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}

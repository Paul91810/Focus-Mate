part of 'pomodoro_timer_bloc.dart';

@immutable
sealed class PomodoroTimerState {}

class PomodoroTimerInitial extends PomodoroTimerState {
  final int workTimeInMinutes;
  final int remainingSeconds;
  final bool isRunning;
  final Duration totalPausedDuration; 
  PomodoroTimerInitial({
    required this.workTimeInMinutes,
    required this.remainingSeconds,
    required this.isRunning,
    this.totalPausedDuration = Duration.zero, 
  });

  PomodoroTimerInitial copyWith({
    int? workTimeInMinutes,
    int? remainingSeconds,
    bool? isRunning,
    Duration? totalPausedDuration,
  }) {
    return PomodoroTimerInitial(
      workTimeInMinutes: workTimeInMinutes ?? this.workTimeInMinutes,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
      totalPausedDuration: totalPausedDuration ?? this.totalPausedDuration,
    );
  }
}

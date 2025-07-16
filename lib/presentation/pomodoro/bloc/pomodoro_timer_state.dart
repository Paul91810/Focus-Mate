part of 'pomodoro_timer_bloc.dart';

@immutable
sealed class PomodoroTimerState {}

class PomodoroTimerInitial extends PomodoroTimerState {
  final int totalDurationInSeconds;
  final int remainingSeconds;
  final bool isRunning;
  final Duration totalPausedDuration;

  PomodoroTimerInitial({
    required this.totalDurationInSeconds,
    required this.remainingSeconds,
    required this.isRunning,
    this.totalPausedDuration = Duration.zero,
  });

  PomodoroTimerInitial copyWith({
    int? totalDurationInSeconds,
    int? remainingSeconds,
    bool? isRunning,
    Duration? totalPausedDuration,
  }) {
    return PomodoroTimerInitial(
      totalDurationInSeconds: totalDurationInSeconds ?? this.totalDurationInSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
      totalPausedDuration: totalPausedDuration ?? this.totalPausedDuration,
    );
  }
}

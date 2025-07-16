class PomodoroTimer {
  final int workTimeInMinutes;
  final Duration totalPausedDuration;
  final String percentage;
  PomodoroTimer({
    required this.workTimeInMinutes,
    required this.percentage,
    required this.totalPausedDuration,
  });
}

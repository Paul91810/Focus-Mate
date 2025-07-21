import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:focus_mate/data/local/hive_boxs.dart';
import 'package:focus_mate/data/local/hive_keys.dart';
import 'package:focus_mate/data/notifications/notifications.dart';
import 'package:meta/meta.dart';

part 'pomodoro_timer_event.dart';
part 'pomodoro_timer_state.dart';

class PomodoroTimerBloc extends Bloc<PomodoroTimerEvent, PomodoroTimerInitial> {
  Timer? timer;
  DateTime? pauseTime;
  DateTime? resumeTime;
  bool hasShownSlowNotification = false;
  Duration totalPausedDuration = Duration.zero;

  PomodoroTimerBloc() : super(_loadStateFromHive()) {
    on<StartTimer>(_onStartTimer);
    on<PauseTimer>(_onPauseTimer);
    on<ResetTimer>(_onResetTimer);
    on<Tick>(_onTick);
    on<SetCustomTime>(_onSetCustomTime);

    if (state.isRunning) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) => add(Tick()));
    }
  }

  static PomodoroTimerInitial _loadStateFromHive() {
    final box = AppHiveBox.pomodoroBox;
    final totalDurationInSeconds = box.get(
      HiveKeys.totalDurationInSeconds,
      defaultValue: 0,
    );
    final startTimeString = box.get(HiveKeys.startTime);
    final isRunning = box.get(HiveKeys.isRunning, defaultValue: false);
    Duration totalPausedDuration = Duration(
      seconds: box.get(HiveKeys.totalPausedDuration, defaultValue: 0),
    );
    int remainingSeconds = box.get(HiveKeys.remainingSeconds, defaultValue: 0);

    if (startTimeString != null) {
      final startTime = DateTime.parse(startTimeString);
      final elapsed = DateTime.now().difference(startTime).inSeconds;
      remainingSeconds = (totalDurationInSeconds - elapsed).clamp(
        0,
        totalDurationInSeconds,
      );
    }

    return PomodoroTimerInitial(
      totalDurationInSeconds: totalDurationInSeconds,
      remainingSeconds: remainingSeconds,
      isRunning: isRunning && remainingSeconds > 0,
      totalPausedDuration: totalPausedDuration,
    );
  }

  void _onStartTimer(StartTimer event, Emitter<PomodoroTimerInitial> emit) {
    if (!state.isRunning && pauseTime != null) {
      resumeTime = DateTime.now();
      final pausedDuration = resumeTime!.difference(pauseTime!);
      totalPausedDuration += pausedDuration;
      emit(
        state.copyWith(
          isRunning: true,
          totalPausedDuration: totalPausedDuration,
        ),
      );
      pauseTime = null;
    }

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => add(Tick()));
    emit(state.copyWith(isRunning: true));
    _saveStateToHive(state.copyWith(isRunning: true));
  }

  void _onPauseTimer(
    PauseTimer event,
    Emitter<PomodoroTimerInitial> emit,
  ) async {
    timer?.cancel();
    pauseTime = DateTime.now();
    emit(state.copyWith(isRunning: false));
    _saveStateToHive(state.copyWith(isRunning: false));
  }

  void _onResetTimer(ResetTimer event, Emitter<PomodoroTimerInitial> emit) {
    timer?.cancel();
    emit(
      state.copyWith(
        remainingSeconds: 0,
        totalDurationInSeconds: 0,
        isRunning: false,
        totalPausedDuration: Duration.zero,
      ),
    );
    _saveStateToHive(state.copyWith(isRunning: false));
  }

  void _onTick(Tick event, Emitter<PomodoroTimerInitial> emit) {
    if (state.remainingSeconds > 0) {
      emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));

      // ✅ Check paused percentage only once
      if (!hasShownSlowNotification) {
        final pausedTime = totalPausedDuration.inMinutes;
        final totalTime = (state.totalDurationInSeconds / 60).round();

        final activePercentage = _getTotalPercentage(pausedTime, totalTime);

        if (activePercentage <= 50) {
          NotificationService.showNotification(
            title: "You're Moving Too Slow",
            body:
                "You’ve paused more than 50% of your focus time. Stay on track!",
          );
          hasShownSlowNotification = true;
        }
      }
    } else {
      // Countdown finished logic
      timer?.cancel();
      emit(state.copyWith(isRunning: false));

      getInvertedPercentage(
        state.totalDurationInSeconds,
        state.remainingSeconds,
      );

      _getTotalPercentage(
        totalPausedDuration.inMinutes,
        (state.totalDurationInSeconds / 60).round(),
      );

      // PomodoroTimer(
      //   workTimeInMinutes: (state.totalDurationInSeconds / 60).round(),
      //   totalPausedDuration: state.totalPausedDuration,
      //   percentage: percentage,
      // );

      NotificationService.showNotification(
        title: 'Focus Mode Completed',
        body:
            "Your focus session has finished. You can now review your progress or start a new session.",
      );

      emit(
        state.copyWith(
          remainingSeconds: 0,
          totalDurationInSeconds: 0,
          isRunning: false,
          totalPausedDuration: Duration.zero,
        ),
      );
    }

    _saveStateToHive(state);
  }

  void _onSetCustomTime(
    SetCustomTime event,
    Emitter<PomodoroTimerInitial> emit,
  ) {
    timer?.cancel();
    emit(
      state.copyWith(
        totalDurationInSeconds: event.totalSeconds,
        remainingSeconds: event.totalSeconds,
        isRunning: false,
      ),
    );
    _saveStateToHive(state.copyWith(isRunning: false));
  }

  int _getTotalPercentage(int pausedTime, int time) {
    final activeTime = pausedTime >= time ? 0 : (time - pausedTime);
    final percentage = (activeTime / time) * 100;
    final roundedPercentage = percentage.round();
    log(roundedPercentage.toString());
    return roundedPercentage;
  }

  String getInvertedPercentage(
    int totalDurationInSeconds,
    int remainingSeconds,
  ) {
    if (totalDurationInSeconds == 0) return "0";
    if (remainingSeconds == 0) return "100";
    final completed =
        ((totalDurationInSeconds - remainingSeconds) / totalDurationInSeconds) *
            100;
    return completed.toInt().toString();
  }

  void _saveStateToHive(PomodoroTimerInitial state) {
    AppHiveBox.pomodoroBox.put(
      HiveKeys.totalDurationInSeconds,
      state.totalDurationInSeconds,
    );
    AppHiveBox.pomodoroBox.put(HiveKeys.remainingSeconds, state.remainingSeconds);
    AppHiveBox.pomodoroBox.put(HiveKeys.isRunning, state.isRunning);
    AppHiveBox.pomodoroBox.put(
      HiveKeys.totalPausedDuration,
      state.totalPausedDuration.inSeconds,
    );
    if (state.isRunning) {
      AppHiveBox.pomodoroBox.put(
        HiveKeys.startTime,
        DateTime.now()
            .subtract(
              Duration(
                seconds: state.totalDurationInSeconds - state.remainingSeconds,
              ),
            )
            .toIso8601String(),
      );
    }
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}

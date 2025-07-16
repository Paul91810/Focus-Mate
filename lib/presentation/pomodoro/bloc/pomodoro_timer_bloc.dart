import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:focus_mate/data/local/pomodoro_timer.dart';
import 'package:meta/meta.dart';

part 'pomodoro_timer_event.dart';
part 'pomodoro_timer_state.dart';

class PomodoroTimerBloc extends Bloc<PomodoroTimerEvent, PomodoroTimerInitial> {
  Timer? timer;
  DateTime? pauseTime;
  DateTime? resumeTime;
  Duration totalPausedDuration = Duration.zero;

  PomodoroTimerBloc()
      : super(PomodoroTimerInitial(
          totalDurationInSeconds: 0,
          remainingSeconds: 0,
          isRunning: false,
        )) {
    on<StartTimer>(_onStartTimer);
    on<PauseTimer>(_onPauseTimer);
    on<ResetTimer>(_onResetTimer);
    on<Tick>(_onTick);
    on<SetCustomTime>(_onSetCustomTime);
  }

  void _onStartTimer(StartTimer event, Emitter<PomodoroTimerInitial> emit) {
    if (!state.isRunning && pauseTime != null) {
      resumeTime = DateTime.now();
      final pausedDuration = resumeTime!.difference(pauseTime!);
      totalPausedDuration += pausedDuration;
      emit(state.copyWith(
        isRunning: true,
        totalPausedDuration: totalPausedDuration,
      ));

      log("Paused for: ${pausedDuration.inMinutes} minutes");
      log("Total paused time: ${totalPausedDuration.inMinutes} minutes");

      pauseTime = null;
    }

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => add(Tick()));
    emit(state.copyWith(isRunning: true));
  }

  void _onPauseTimer(PauseTimer event, Emitter<PomodoroTimerInitial> emit) {
    timer?.cancel();
    pauseTime = DateTime.now();
    emit(state.copyWith(isRunning: false));
  }

  void _onResetTimer(ResetTimer event, Emitter<PomodoroTimerInitial> emit) {
    timer?.cancel();
    emit(state.copyWith(
      remainingSeconds: 0,
      totalDurationInSeconds: 0,
      isRunning: false,
      totalPausedDuration: Duration.zero,
    ));
  }

  void _onTick(Tick event, Emitter<PomodoroTimerInitial> emit) {
    if (state.remainingSeconds > 0) {
      emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
    } else {
      timer?.cancel();
      emit(state.copyWith(isRunning: false));

      final percentage = getInvertedPercentage(
        state.totalDurationInSeconds,
        state.remainingSeconds,
      );

      PomodoroTimer(
        workTimeInMinutes: (state.totalDurationInSeconds / 60).round(),
        totalPausedDuration: state.totalPausedDuration,
        percentage: percentage,
      );
    }
  }

  void _onSetCustomTime(SetCustomTime event, Emitter<PomodoroTimerInitial> emit) {
    timer?.cancel();
    emit(state.copyWith(
      totalDurationInSeconds: event.totalSeconds,
      remainingSeconds: event.totalSeconds,
      isRunning: false,
    ));
  }

  String getInvertedPercentage(int totalDurationInSeconds, int remainingSeconds) {
    if (totalDurationInSeconds == 0) return "0";
    if (remainingSeconds == 0) return "100";
    final completed =
        ((totalDurationInSeconds - remainingSeconds) / totalDurationInSeconds) * 100;
    return completed.toInt().toString();
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}

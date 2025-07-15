import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pomodoro_timer_event.dart';
part 'pomodoro_timer_state.dart';

class PomodoroTimerBloc extends Bloc<PomodoroTimerEvent, PomodoroTimerInitial> {
  Timer? timer;
  DateTime? pauseTime;
  DateTime? resumeTime;
  Duration totalPausedDuration = Duration.zero;

  PomodoroTimerBloc()
    : super(
        PomodoroTimerInitial(
          workTimeInMinutes: 0,
          remainingSeconds: 0,
          isRunning: false,
        ),
      ) {
    on<StartTimer>(_onStartTimer);
    on<PauseTimer>(_onPauseTimer);
    on<ResetTimer>(_onResetTimer);
    on<Tick>(_onTick);
    on<SetWorkTime>(_onSetWorkTime);
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

      log("Paused for: ${pausedDuration.inMinutes} minuts");
      log("Total paused time: ${totalPausedDuration.inMinutes} minuts");

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
    emit(
      state.copyWith(
        remainingSeconds: 0,
        isRunning: false,
        totalPausedDuration: Duration.zero,
      ),
    );
  }

  void _onTick(Tick event, Emitter<PomodoroTimerInitial> emit) {
    if (state.remainingSeconds > 0) {
      emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
    } else {
      timer?.cancel();
      emit(state.copyWith(isRunning: false));
    }
  }

  void _onSetWorkTime(SetWorkTime event, Emitter<PomodoroTimerInitial> emit) {
    timer?.cancel();
    emit(
      PomodoroTimerInitial(
        workTimeInMinutes: event.minutes,
        remainingSeconds: event.minutes * 60,
        isRunning: false,
      ),
    );
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}

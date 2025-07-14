import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pomodoro_timer_event.dart';
part 'pomodoro_timer_state.dart';

class PomodoroTimerBloc extends Bloc<PomodoroTimerEvent, PomodoroTimerInitial> {
  Timer? timer;

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
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => add(Tick()));
    emit(state.copyWith(isRunning: true));
  }

  void _onPauseTimer(PauseTimer event, Emitter<PomodoroTimerInitial> emit) {
    timer?.cancel();
    emit(state.copyWith(isRunning: false));
  }

  void _onResetTimer(ResetTimer event, Emitter<PomodoroTimerInitial> emit) {
    timer?.cancel();
    emit(
      state.copyWith(
        remainingSeconds: 0,
        isRunning: false,
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

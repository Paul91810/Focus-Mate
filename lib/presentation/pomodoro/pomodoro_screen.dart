import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/presentation/pomodoro/bloc/pomodoro_timer_bloc.dart';
import 'package:focus_mate/presentation/widgets/custom_elvated_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  String formatTime(int seconds) {
    int min = seconds ~/ 60;
    int sec = seconds % 60;
    return '$min:${sec.toString().padLeft(2, '0')}';
  }

  String getInvertedPercentage(int workTimeInMinutes, int remainingSeconds) {
    if (remainingSeconds == 0) return "100";
    final data =
        ((workTimeInMinutes * 60 - remainingSeconds) /
            (workTimeInMinutes * 60)) *
        100;
    return data.toInt().toString();
  }

  Color setColor(String remainingSeconds) {
    final intStatus = int.tryParse(remainingSeconds);
    if (intStatus == null) {
      return Colors.transparent;
    }
    Color percentage = Colors.blue;
    if (intStatus <= 50) {
      percentage = Colors.red;
    } else if (intStatus >= 51) {
      percentage = Colors.green;
    }
    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PomodoroTimerBloc(),
      child: BlocBuilder<PomodoroTimerBloc, PomodoroTimerInitial>(
        builder: (context, state) {
          final bloc = context.read<PomodoroTimerBloc>();
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
            children: [
              Text('Pomodoro Timer', style: TextTheme.of(context).titleLarge),
              SizedBox(height: 30.h),
              Center(
                child: GestureDetector(
                  onTap: state.remainingSeconds != 0
                      ? null
                      : () {
                          _showFinishPopup(context);
                        },
                  child: CircularPercentIndicator(
                    radius: 160.w,
                    lineWidth: 15.w,
                    percent: state.workTimeInMinutes == 0
                        ? 0
                        : (state.remainingSeconds /
                                  (state.workTimeInMinutes * 60))
                              .clamp(0.0, 1.0),
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatTime(state.remainingSeconds),
                          style: TextTheme.of(context).displaySmall,
                        ),
                        AppSize.commonHeight,
                        Text(
                          state.remainingSeconds == 0
                              ? 'Tap here to set focus time'
                              : 'Time to focus.!',
                        ),
                        AppSize.commonHeight,
                        state.remainingSeconds != 0
                            ? Text(
                                '${getInvertedPercentage(state.workTimeInMinutes, state.remainingSeconds)}%',
                                style: TextStyle(
                                  color: setColor(
                                    getInvertedPercentage(
                                      state.workTimeInMinutes,
                                      state.remainingSeconds,
                                    ),
                                  ),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.sp,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    progressColor: Colors.blue,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              AppSize.height20,
              state.remainingSeconds != 0
                  ? TextButton(
                      onPressed: () {
                        _showFinishPopup(context);
                      },
                      child: Text(
                        'Change of Plans? Set a New Focus Time',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 50.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAppElvatedButton(
                    backGroundcolor: AppColors.kButtonBlue,
                    buttonSize: Size(150.w, 40.h),
                    child: Text(
                      state.isRunning ? "Pause" : "Start",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                    onPressed: () async {
                      state.isRunning
                          ? bloc.add(PauseTimer())
                          : bloc.add(StartTimer());
                    },
                  ),
                  CustomAppElvatedButton(
                    backGroundcolor: Colors.white70,
                    buttonSize: Size(150.w, 40.h),
                    child: Text(
                      'Skip',
                      style: TextStyle(color: AppColors.kPrimaryColor),
                    ),
                    onPressed: () async {
                      bloc.add(ResetTimer());
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _showFinishPopup(BuildContext context) {
    final bloc = context.read<PomodoroTimerBloc>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kButtonBlue,
          title: Text("Set Time"),
          actions: [
            TextButton(
              onPressed: () {
                bloc.add(SetWorkTime(2));
                Navigator.of(context).pop();
              },
              child: Text("OK", style: TextTheme.of(context).bodySmall),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/data/notifications/notifications.dart';
import 'package:focus_mate/presentation/pomodoro/bloc/pomodoro_timer_bloc.dart';
import 'package:focus_mate/presentation/widgets/custom_elvated_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen>
    with SingleTickerProviderStateMixin {
  String formatTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  Color setColor(String remainingPercentage) {
    final intStatus = int.tryParse(remainingPercentage);
    if (intStatus == null) {
      return Colors.transparent;
    }
    if (intStatus <= 50) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PomodoroTimerBloc(),
      child: BlocBuilder<PomodoroTimerBloc, PomodoroTimerInitial>(
        builder: (context, state) {
          final bloc = context.read<PomodoroTimerBloc>();
          final percentage = bloc.getInvertedPercentage(
            state.totalDurationInSeconds,
            state.remainingSeconds,
          );

          final double progress = state.totalDurationInSeconds == 0
              ? 0
              : (state.remainingSeconds / state.totalDurationInSeconds).clamp(
                  0.0,
                  1.0,
                );

          return ListView(
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
            children: [
              Center(
                child: GestureDetector(
                  onTap: state.remainingSeconds != 0
                      ? null
                      : () => _showsetTime(context),
                  child: CircularPercentIndicator(
                    radius: 160.w,
                    lineWidth: 15.w,
                    percent: progress,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: state.remainingSeconds != 0
                              ? MainAxisAlignment.spaceEvenly
                              : MainAxisAlignment.center,
                          children: [
                            Text(
                              formatTime(state.remainingSeconds),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            if (state.remainingSeconds != 0)
                              Text(
                                '$percentage%',
                                style: TextStyle(
                                  color: setColor(percentage),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.sp,
                                ),
                              ),
                          ],
                        ),
                        AppSize.commonHeight,
                        Text(
                          state.remainingSeconds == 0
                              ? 'Tap here to set focus time'
                              : 'Time to focus!',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    progressColor: AppColors.kSecondryColor,
                    backgroundColor: AppColors.kPrimaryColor,
                  ),
                ),
              ),
              AppSize.height20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAppElvatedButton(
                    backGroundcolor: AppColors.kButtonBlue,
                    buttonSize: Size(150.w, 40.h),
                    onPressed: state.remainingSeconds == 0
                        ? () async {}
                        : () async {
                            state.isRunning
                                ? bloc.add(PauseTimer())
                                : bloc.add(StartTimer());
                          },
                    child: Text(
                      state.isRunning ? "Pause" : "Start",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
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

  void _showsetTime(BuildContext context) {
    final bloc = context.read<PomodoroTimerBloc>();
    int selectedHour = 0;
    int selectedMinuteIndex = 0;
    int selectedSecond = 59;

    final List<int> minuteOptions = [for (int i = 5; i <= 55; i += 5) i, 59];

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 350,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.kSecondryColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 50,
                        onSelectedItemChanged: (index) {
                          selectedHour = index;
                        },
                        children: List.generate(
                          24,
                          (index) => Center(child: Text("$index hr")),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 50,
                        onSelectedItemChanged: (index) {
                          selectedMinuteIndex = index;
                        },
                        children: minuteOptions
                            .map((minute) => Center(child: Text("$minute min")))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  color: AppColors.kPrimaryColor,
                  child: const Text("Set Time"),
                  onPressed: () {
                    int selectedMinute = minuteOptions[selectedMinuteIndex];

                    int totalSeconds =
                        (selectedHour * 3600) +
                        (selectedMinute * 60) +
                        selectedSecond;

                    if (totalSeconds > 0) {
                      bloc.add(SetCustomTime(totalSeconds));

                      Navigator.of(context).pop();
                      NotificationService.showNotification(
                        title: 'Focus Mode Activated',
                        body:
                            "Stay focused on your task. Minimize distractions and make the most of your session.",
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

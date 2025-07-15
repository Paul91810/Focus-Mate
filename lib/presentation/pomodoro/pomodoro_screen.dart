import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
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
  String formatTime(int seconds) {
    int min = seconds ~/ 60;
    int sec = seconds % 60;
    return '$min:${sec.toString().padLeft(2, '0')}';
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
          final percentage = bloc.getInvertedPercentage(
            state.workTimeInMinutes,
            state.remainingSeconds,
          );
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
            children: [
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
                    percent:
                        (state.remainingSeconds /
                                (state.workTimeInMinutes * 60))
                            .clamp(0.0, 1.0),
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
                              style: TextTheme.of(context).displayLarge,
                            ),

                            Text(
                              state.remainingSeconds != 0 ? '$percentage%' : '',
                              style: TextStyle(
                                color: setColor(percentage),
                                fontWeight: FontWeight.bold,
                                fontSize: 40.sp,
                              ),
                            ),
                          ],
                        ),
                        AppSize.commonHeight,
                        Text(
                          state.remainingSeconds == 0
                              ? 'Tap here to set focus time'
                              : 'Time to focus.!',
                          style: TextTheme.of(context).labelLarge,
                        ),
                      ],
                    ),
                    progressColor: Colors.blue,
                    backgroundColor: Colors.white,
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
                      style: TextTheme.of(context).bodyLarge,
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

  void _showFinishPopup(BuildContext context) {
    final bloc = context.read<PomodoroTimerBloc>();
    final items = List.generate(61, (index) => index);
    int selectedValue = 0;

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 350.h,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.kButtonBlue,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 50.h,
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  onSelectedItemChanged: (index) {
                    selectedValue = items[index];
                  },
                  children: items
                      .map((value) => Center(child: Text("$value min")))
                      .toList(),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  child: Text("Set Time"),
                  onPressed: () {
                    bloc.add(SetWorkTime(selectedValue));
                    Navigator.of(context).pop();
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

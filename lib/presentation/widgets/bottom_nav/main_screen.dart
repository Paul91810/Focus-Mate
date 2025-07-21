import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/presentation/home/home_screen.dart';
import 'package:focus_mate/presentation/pomodoro/pomodoro_screen.dart';
import 'package:focus_mate/presentation/profile/profile_screen.dart';
import 'package:focus_mate/presentation/daily_planner/daily_planner_screen.dart';
import 'package:focus_mate/presentation/widgets/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:focus_mate/presentation/widgets/bottom_nav/bottom_nav_bar.dart';
import 'package:focus_mate/presentation/widgets/custom_elvated_button.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'Home',
      'Pomodoro Timer',
      'Smart Task Planner',
      'Profile',
    ];
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          final bloc = context.read<BottomNavBloc>();

          return WillPopScope(
            onWillPop: () async {
              if (state is BottomNavInitial) {
                final nav = state;

                if (nav.currentIndex != 0) {
                  bloc.add(PopLastTab());
                  return false;
                }
              }
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                actionsPadding: EdgeInsets.symmetric(horizontal: 20.w),
                automaticallyImplyLeading: false,
                title: Text(titles[state.currentIndex]),
                actions: [Icon(Icons.notifications)],
              ),
              backgroundColor: AppColors.kPrimaryColor,
              body: state is BottomNavInitial
                  ? IndexedStack(
                      index: state.currentIndex,
                      children: bottomScreens,
                    )
                  : const SizedBox.shrink(),
              bottomNavigationBar: BottomNavBar(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
          );
        },
      ),
    );
  }

  final List<Widget> bottomScreens = [
    HomeScreen(),
    PomodoroScreen(),
    DailyPlan(),
    ProfileAndStatusScreen(),
  ];
}

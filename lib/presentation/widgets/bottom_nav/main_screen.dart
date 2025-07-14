import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/presentation/home/home_screen.dart';
import 'package:focus_mate/presentation/pomodoro/pomodoro_screen.dart';
import 'package:focus_mate/presentation/profile_and_status/profile_and_status_screen.dart';
import 'package:focus_mate/presentation/smart_task_planner/smart_task_panner_screen.dart';
import 'package:focus_mate/presentation/widgets/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:focus_mate/presentation/widgets/bottom_nav/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            
              appBar: AppBar(),
              // appBar: AppBarWidget(
              //   profileType: ProfileType.parent,
              //   title: Center(
              //     child: Text(
              //       appBartitles[currentIndex],
              //       style: TextStyle(
              //         fontSize: 20.sp,
              //         fontWeight: FontWeight.bold,
              //         color: AppColors.kPrimaryColor,
              //       ),
              //     ),
              //   ),
              // ),
              // drawer: AppDrawer(profileType: ProfileType.parent),
              backgroundColor: AppColors.kPrimaryColor,

              body: state is BottomNavInitial
                  ? IndexedStack(
                      index: state.currentIndex,
                      children: bottomScreens,
                    )
                  : const SizedBox.shrink(),

              bottomNavigationBar: BottomNavBar(),
            ),
          );
        },
      ),
    );
  }

  final List<Widget> bottomScreens = [
    HomeScreen(),
    PomodoroScreen(),
    SmartTaskPannerScreen(),
    ProfileAndStatusScreen(),
  ];
}

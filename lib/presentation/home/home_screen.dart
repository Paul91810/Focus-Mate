import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/core/theme/theme.dart';
import 'package:focus_mate/presentation/notification/notification_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Focus Mate",
                style: TextTheme.of(context).titleLarge,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationsScreen(),
                        ));
                  },
                  child: Icon(
                    Icons.notifications,
                    size: 35,
                  )),
            ],
          ),
          AppSize.height20,
          Row(
            children: [
              Expanded(
                child: _buildCard(
                  width: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "12 tasks\ntoday",
                        style: TextTheme.of(context).titleLarge,
                      ),
                      AppSize.commonHeight,
                      Text("5 completed",
                          style: TextTheme.of(context).bodyLarge),
                      Text("7 remaining",
                          style: TextTheme.of(context).bodyLarge),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: _buildCard(
                  width: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: AppColors.kPrimaryColor,
                        size: 80,
                      ),
                      AppSize.height20,
                      Text(
                        "View Calendar",
                        style: TextTheme.of(context).bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.sp),
          _buildCard(
            width: double.infinity,
            height: 150.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Daily Planner", style: TextTheme.of(context).titleLarge),
                AppSize.commonHeight,
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text("Submit report",
                        style: TextTheme.of(context).bodyLarge),
                    Spacer(),
                    Text("9:00 AM", style: TextTheme.of(context).bodyLarge),
                  ],
                ),
                AppSize.commonHeight,
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.blue, size: 20),
                    SizedBox(width: 8),
                    Text("Team meeting",
                        style: TextTheme.of(context).bodyLarge),
                    Spacer(),
                    Text("11:00 AM", style: TextTheme.of(context).bodyLarge),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 5.sp),
          Row(
            children: [
              Expanded(
                child: _buildCard(
                  width: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Pomodoro", style: TextTheme.of(context).bodyLarge),
                      AppSize.commonHeight,
                      Icon(Icons.note,
                          color: AppColors.kPrimaryColor, size: 100),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: _buildCard(
                  width: 0,
                  child: CircularPercentIndicator(
                    progressColor: AppColors.kWhite,
                    backgroundColor: AppColors.kPrimaryColor,
                    radius: 50.w,
                    percent: 0.70,
                    lineWidth: 10.w,
                    center: Text('START'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required double width,
    double? height,
    required Widget child,
  }) {
    return Card(
      shadowColor: AppColors.kPrimaryColor,
      elevation: 1,
      color: AppColors.kSecondryColor,
      child: Container(
        width: width,
        height: height ?? 200.w,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kSecondryColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

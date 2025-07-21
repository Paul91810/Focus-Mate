import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/presentation/daily_planner/widgets/create_pan_details.dart';
import 'package:focus_mate/presentation/daily_planner/widgets/plan_details_screen.dart';

class DailyPlan extends StatelessWidget {
  const DailyPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
               child: Text(
                  "Smart Task Planner",
                  style: TextTheme.of(context).titleLarge,
                ),
             ),
            const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              dividerColor: Colors.transparent,
              tabs: [
                Tab(text: 'Create Plan'),
                Tab(text: 'Plan Details'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [PlanCreator(), PlanDetails()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

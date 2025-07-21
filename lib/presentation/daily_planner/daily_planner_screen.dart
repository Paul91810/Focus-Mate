import 'package:flutter/material.dart';
import 'package:focus_mate/presentation/daily_planner/widgets/create_pan_details.dart';
import 'package:focus_mate/presentation/daily_planner/widgets/plan_details_screen.dart';

class DailyPlan extends StatelessWidget {
  const DailyPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
    );
  }
}

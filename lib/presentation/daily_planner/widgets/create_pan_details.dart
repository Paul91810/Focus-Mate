import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/data/repo/motivation_repo.dart';
import 'package:focus_mate/presentation/daily_planner/bloc/plan_creator_bloc.dart';
import 'package:focus_mate/presentation/widgets/custom_elvated_button.dart';
import 'package:focus_mate/presentation/widgets/custom_textfield/custom_textfield.dart';

class PlanCreator extends StatelessWidget {
  const PlanCreator({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController taskController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    GetMotivationRepo motivation = GetMotivationRepo();
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      children: [
        Text(
          'Generate task ideas with AI to boost your productivity',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        AppSize.height20,
        FutureBuilder(
          future: motivation.getMotivationCombo(),
          builder: (context, snapshot) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              width: double.infinity,
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.kSecondryColor,
              ),
              child: Center(
                child: Text(
                  snapshot.data?.content?.text ??
                      'Draft project proposal Organize your workspace Review meeting notes',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          },
        ),
        AppSize.height20,
        Text('What would you like to accomplish'),
        AppSize.height20,
        BlocProvider(
          create: (_) => DailyPlannerBloc(),
          child: BlocBuilder<DailyPlannerBloc, DailyPlannerState>(
            builder: (context, state) {
              List<String> tasks = [];
              int? selectedIndex;

              if (state is TaskUpdated) {
                tasks = state.tasks;
                selectedIndex = state.selectedIndex;
              }
              return Column(
                children: [
                  Form(
                    key: formKey,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            controller: taskController,
                            label: 'Enter a Task',
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter a task';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomAppElvatedButton(
                            backGroundcolor: AppColors.kButtonBlue,
                            child: Text(
                              '+ Add',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                context.read<DailyPlannerBloc>().add(
                                      AddTaskEvent(taskController.text),
                                    );
                                taskController.clear();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSize.commonHeight,
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Radio<int>(
                          value: index,
                          groupValue: selectedIndex,
                          activeColor: AppColors.kButtonBlue,
                          onChanged: (int? value) {
                            if (value != null) {
                              context.read<DailyPlannerBloc>().add(
                                    SelectTaskEvent(value),
                                  );
                            }
                          },
                        ),
                        title: Text(tasks[index]),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

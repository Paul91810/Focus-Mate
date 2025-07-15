part of 'plan_creator_bloc.dart';

@immutable
sealed class DailyPlannerState {}

class TaskInitial extends DailyPlannerState {}

class TaskUpdated extends DailyPlannerState {
  final List<String> tasks;
  final int? selectedIndex;
  TaskUpdated({required this.tasks, this.selectedIndex});
}

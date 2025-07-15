part of 'plan_creator_bloc.dart';

@immutable
sealed class DailyPlannerEvent {}
class AddTaskEvent extends DailyPlannerEvent {
  final String task;

  AddTaskEvent(this.task,);
}

class SelectTaskEvent extends DailyPlannerEvent {
  final int selectedIndex;
  SelectTaskEvent(this.selectedIndex);
}
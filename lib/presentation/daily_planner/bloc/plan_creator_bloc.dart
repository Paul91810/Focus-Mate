import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'plan_creator_event.dart';
part 'plan_creator_state.dart';

class DailyPlannerBloc
    extends Bloc<DailyPlannerEvent, DailyPlannerState> {
  List<String> tasks = [];
  int? selectedIndex;
  DailyPlannerBloc() : super(TaskInitial()) {
    on<AddTaskEvent>((event, emit) {
      tasks.add(event.task);
      emit(TaskUpdated(tasks: List.from(tasks), selectedIndex: selectedIndex));
    });
    on<SelectTaskEvent>((event, emit) {
      selectedIndex = event.selectedIndex;
      emit(TaskUpdated(tasks: List.from(tasks), selectedIndex: selectedIndex));
    });
  }
}

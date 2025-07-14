import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavInitial> {
  BottomNavBloc()
    : super(BottomNavInitial(currentIndex: 0, navigationStack: [])) {
    on<BottomItamTaped>((event, emit) {
      final current = state;
      if (event.index == current.currentIndex) return;
      final newStack = List<int>.from(current.navigationStack);
      if (newStack.isEmpty || newStack.last != event.index) {
        newStack.remove(event.index);
        newStack.add(event.index);
      }
      emit(
        BottomNavInitial(currentIndex: event.index, navigationStack: newStack),
      );
    });
     on<PopLastTab>((event, emit) {
      final current = state;
      if (current.navigationStack.isEmpty) return;
      final newStack = List<int>.from(current.navigationStack)..removeLast();
      final newIndex = newStack.isNotEmpty ? newStack.last : 0;
      emit(BottomNavInitial(currentIndex: newIndex, navigationStack: newStack));
});
  }
  }


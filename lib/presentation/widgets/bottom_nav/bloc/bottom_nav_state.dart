part of 'bottom_nav_bloc.dart';

@immutable
sealed class BottomNavState {
 int get currentIndex => 0;
}

final class BottomNavInitial extends BottomNavState {
  final int currentIndex;
  final List<int> navigationStack;
  BottomNavInitial({required this.currentIndex, required this.navigationStack});
}

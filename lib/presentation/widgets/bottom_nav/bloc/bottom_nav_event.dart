part of 'bottom_nav_bloc.dart';

@immutable
sealed class BottomNavEvent {}

class BottomItamTaped extends BottomNavEvent {
  final int index;
  BottomItamTaped(this.index);
}

class PopLastTab extends BottomNavEvent {}

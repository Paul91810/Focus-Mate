part of 'custom_textfield_bloc.dart';

@immutable
sealed class CustomTextfieldEvent {}


final class NotifyValue extends CustomTextfieldEvent{
  final String value;
  NotifyValue(this.value);
}

final class ToggleObscureText extends CustomTextfieldEvent{}

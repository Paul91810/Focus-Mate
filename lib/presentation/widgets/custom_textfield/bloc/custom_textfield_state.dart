part of 'custom_textfield_bloc.dart';

@immutable
sealed class CustomTextfieldState {}

final class CustomTextfieldInitial extends CustomTextfieldState {
  final String value;
  final String? error;
  final bool? obscureText;
  CustomTextfieldInitial({
    required this.value,
    required this.error,
     this.obscureText=false,
  });

  CustomTextfieldInitial copyWith({
    String? value,
    String? erorr,
    bool? obscureText,
  }) {
    return CustomTextfieldInitial(
      value: value ?? this.value,
      error: error,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}

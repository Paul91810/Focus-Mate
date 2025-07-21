import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'custom_textfield_event.dart';
part 'custom_textfield_state.dart';

typedef Validator = String? Function(String value);

class CustomTextfieldBloc
    extends Bloc<CustomTextfieldEvent, CustomTextfieldState> {
  final Validator validator;
  final bool isPassword;
  CustomTextfieldBloc(this.validator, {this.isPassword = false})
    : super(
        CustomTextfieldInitial(value: '', error: null, obscureText: isPassword),
      ) {
    on<NotifyValue>((event, emit) {
      final text = event.value.trim();
      final erorr = validator(text);
      emit(
        (state as CustomTextfieldInitial).copyWith(value: text, erorr: erorr),
      );
    });
    on<ToggleObscureText>((event, emit) {
      final current = state as CustomTextfieldInitial;
      emit(current.copyWith(obscureText: !(current.obscureText ?? false)));
    });
  }
}

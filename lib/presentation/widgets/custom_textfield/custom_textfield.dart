import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/presentation/widgets/custom_textfield/bloc/custom_textfield_bloc.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    this.isPassword = false,
  });
  final TextEditingController controller;
  final String label;
  final Validator validator;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomTextfieldBloc(validator, isPassword: isPassword),
      child: BlocBuilder<CustomTextfieldBloc, CustomTextfieldState>(
        builder: (context, state) {
          final bloc = context.read<CustomTextfieldBloc>();
          final fieldState = state as CustomTextfieldInitial;

          return Column(
            children: [
              TextFormField(
                controller: controller,
                obscureText: fieldState.obscureText ?? false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => validator(value ?? ''),
                onChanged: (value) => bloc.add(NotifyValue(value)),
                decoration: InputDecoration(
                  labelText: label,
                  errorText: fieldState.error,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: isPassword
                      ? IconButton(
                          icon: Icon(
                            fieldState.obscureText ?? false
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => bloc.add(ToggleObscureText()),
                        )
                      : null,
                ),
              ),
              AppSize.commonHeight,
            ],
          );
        },
      ),
    );
  }
}

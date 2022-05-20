import 'package:flutter/material.dart';
import 'package:prixz_test/shared/presentation/color_constants.dart';

class TextFieldWidget extends StatelessWidget {
  final Widget? prefix;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool shouldValidate, readOnly;
  final String? Function(String?)? validator;
  const TextFieldWidget({
    Key? key,
    this.prefix,
    required this.hintText,
    required this.onChanged,
    required this.shouldValidate,
    required this.validator,
    this.readOnly = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      autocorrect: false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        prefixIcon: prefix,
        fillColor: ColorConstants.whiteColor,
        filled: true,
      ),
      onChanged: onChanged,
      autovalidateMode: shouldValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      validator: validator,
    );
  }
}

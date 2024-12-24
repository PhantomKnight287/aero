import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final int? maxLines;
  final int? minLines;
  final bool? readOnly;
  final InputBorder? border;
  final Function(String)? onChanged;
  final Color? fillColor;
  final Color? prefixIconColor;
  final InputBorder? enabledBorder;
  final bool? enabled;
  final int? hintMaxLines;
  final bool? autoFocus;
  final bool? hideKeyboardOnClickOutside;
  final List<String>? autofillHints;
  const InputField({
    required this.hintText,
    required this.keyboardType,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
    this.hintStyle,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.readOnly,
    this.border,
    this.fillColor,
    this.prefixIconColor,
    this.enabledBorder,
    this.enabled,
    this.hintMaxLines,
    this.autoFocus,
    this.hideKeyboardOnClickOutside,
    this.autofillHints,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus ?? false,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText ?? false,
      minLines: minLines,
      autofillHints: autofillHints,
      maxLines: obscureText == null
          ? maxLines
          : obscureText == true
              ? 1
              : maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        hintMaxLines: hintMaxLines,
        contentPadding: const EdgeInsets.all(8.0),
        enabledBorder: enabledBorder,
        enabled: enabled ?? true,
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
        prefixIconColor: Colors.black,
        fillColor: fillColor,
        filled: true,
        hintStyle: hintStyle ??
            TextStyle(
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
            ),
        suffixIcon: suffixIcon,
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
        ),
      ),
      validator: validator,
      onChanged: onChanged,
      onTapOutside: (event) {
        if (hideKeyboardOnClickOutside != null && hideKeyboardOnClickOutside == true) {
          FocusScope.of(context).unfocus();
        }
      },
    );
  }
}

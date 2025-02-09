import 'package:flutter/material.dart';
import 'package:lib_common/lib_common.dart';

import '../../../lib_style.dart';
import 'svg_image_widget.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    required this.controller,
    required this.style,
    this.hintStyle,
    this.onTap,
    this.suffixIcon,
    this.readOnly = false,
  });
  final String hintText;
  final String prefixIcon;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final bool readOnly;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextStyle style;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final Resources res = getIt<Resources>();
    return TextFormField(
      controller: controller,
      style: style,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hintText,
        helperText: '',
        hintStyle: hintStyle ?? res.themes.titleMedium16,
        contentPadding: const EdgeInsets.symmetric(vertical: 15), // Add vertical padding
        prefixIcon: Container(
          margin: const EdgeInsets.all(8),
          child: SvgImageWidget(
            svgImage: prefixIcon,
            height: 24,
            width: 24,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 56,
        ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIcon != null
            ? const BoxConstraints(
                maxHeight: 56,
              )
            : null,
        isDense: true,
        fillColor: res.themes.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: res.themes.lightGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: res.themes.lightGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: res.themes.lightGrey,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: res.themes.red,
          ),
        ),
      ),
      validator: (String? value) => validator(value),
    );
  }
}

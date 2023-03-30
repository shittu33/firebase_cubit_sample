import 'package:flutter/material.dart';
import 'package:liberty_app/app/theme.dart';

class UnderLinedTextFormField extends StatelessWidget {
  const UnderLinedTextFormField(
      {Key? key, this.label, this.suffix, this.onChanged, this.errorText})
      : super(key: key);
  final Widget? label;
  final Widget? suffix;
  final Function(String text)? onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: buildInputDecoration(context,
          label: label, suffix: suffix, errorText: errorText),
    );
  }

  static InputDecoration buildInputDecoration(
    BuildContext context, {
    Widget? label,
    Widget? suffix,
    Widget? prefix,
    bool? isCollapsed,
    String? errorText,
  }) {
    return InputDecoration(
      label: label,
      suffixIcon: suffix,
      prefixIcon: prefix,
      prefixIconConstraints: BoxConstraints.tight(const Size(35, 35)),
      isCollapsed: isCollapsed ?? false,
      suffixIconConstraints: BoxConstraints.tight(const Size(23, 23)),
      errorText: errorText,
      labelStyle: Theme.of(context)
          .textTheme
          .overline
          ?.copyWith(color: AppColors.lightGray, fontSize: 13),
      border: UnderlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.lightGray,
        ),
        borderRadius: BorderRadius.circular(
          AppSizes.searchInputRadius,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.lightGray,
        ),
        borderRadius: BorderRadius.circular(
          AppSizes.searchInputRadius,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.primary,
        ),
        borderRadius: BorderRadius.circular(
          AppSizes.searchInputRadius,
        ),
      ),
    );
  }
}

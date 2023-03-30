import 'package:formz/formz.dart';

/// Validation errors for the [date] [FormzInput].
enum DateValidationError {
  /// Generic invalid error.
  invalid
}

/// Form input for an date input.
class Date extends FormzInput<String, DateValidationError> {
  /// {@macro date}
  const Date.pure() : super.pure('');

  /// {@macro date}
  const Date.dirty([String value = '']) : super.dirty(value);

  static final RegExp _descRegExp =
      RegExp('/^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}\$/');

  @override
  DateValidationError? validator(String? value) {
    // return _descRegExp.hasMatch(value ?? '')
    return value?.isNotEmpty == true
        ? null
        : DateValidationError.invalid;
  }
}

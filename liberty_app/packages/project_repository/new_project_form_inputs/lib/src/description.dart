import 'package:formz/formz.dart';

/// Validation errors for the [description] [FormzInput].
enum DescriptionValidationError {
  /// Generic invalid error.
  invalid
}

/// Form input for an description input.
class Description extends FormzInput<String, DescriptionValidationError> {
  /// {@macro description}
  const Description.pure() : super.pure('');

  /// {@macro description}
  const Description.dirty([String value = '']) : super.dirty(value);

  static final RegExp _descRegExp = RegExp('/[0-9a-zA-Z]{6,}/');

  @override
  DescriptionValidationError? validator(String? value) {
    // return _descRegExp.hasMatch(value ?? '')
    final val = value ?? '';
    return val.isNotEmpty && val.length >= 20
        ? null
        : DescriptionValidationError.invalid;
  }
}

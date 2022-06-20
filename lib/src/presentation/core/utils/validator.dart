import '../../../core/utils/string.dart';

class Validator {
  static String? validateEmail(String? value) {
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+",
    );
    if (value.isEmptyOrNull) return 'Enter an email.';
    if (!regExp.hasMatch(value!)) return 'Enter a valid email.';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value.isEmptyOrNull) return 'Enter a password.';
    if (value!.length < 8) {
      return 'Password must contain at least 8 characters.';
    }
    return null;
  }

  static String? validateFirstName(String? value) {
    if (value.isEmptyOrNull) return 'Enter a first name.';
    if (value!.length < 3) {
      return 'First name must contain at least 3 characters.';
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value.isEmptyOrNull) return 'Enter a last name.';
    if (value!.length < 3) {
      return 'Last name must contain at least 3 characters.';
    }
    return null;
  }
}

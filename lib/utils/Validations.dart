class Validations {
  static bool isValidEmail(String email) {
    // Use a regular expression to validate the email format
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String pass) {
    if (pass.length >= 6) {
      return true;
    }
    return false;
  }

  static bool isNumeric(String str) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(str);
  }

  static bool isFourDigitLong(String pass) {
    if (pass.length == 4) {
      return true;
    }
    return false;
  }
}

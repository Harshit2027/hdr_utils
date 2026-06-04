import '../utility/regexp_utils.dart';

class ValidatorUtils {
  /// Validates that a full name is not empty and has between 2 and 30 characters.
  static String? validateFullName(
    String? value, {
    String? emptyError,
    String? lengthError,
  }) {
    value = value?.trim() ?? "";
    if (value.isEmpty) {
      return emptyError ?? "Full name cannot be empty.";
    }
    if (value.length < 2 || value.length > 30) {
      return lengthError ?? "Full name must be between 2 and 30 characters.";
    }
    return null;
  }

  /// Validates that a general field is not empty and has between 2 and 30 characters.
  static String? validateFields(
    String? value,
    String defaultEmptyMessage, {
    String? lengthError,
  }) {
    value = value?.trim() ?? "";
    if (value.isEmpty) {
      return defaultEmptyMessage;
    }
    if (value.length < 2 || value.length > 30) {
      return lengthError ?? "Field must be between 2 and 30 characters.";
    }
    return null;
  }

  /// Validates that an OTP contains only numbers and is not empty.
  static String? validateOtpRequire(
    String? value, {
    String? emptyError,
    String? invalidError,
  }) {
    value = value?.trim() ?? "";
    if (value.isEmpty) {
      return emptyError ?? "OTP code cannot be empty.";
    }
    if (!RegExpUtils.numberRegExp.hasMatch(value)) {
      return invalidError ?? "OTP code must contain only numbers.";
    }
    return null;
  }

  /// Validates that an OTP is entered and has a length of at least 4.
  static String? validateOTP(
    String? value, {
    String? emptyError,
    String? lengthError,
  }) {
    if (value == null) return null;
    value = value.trim();
    if (value.isEmpty) {
      return emptyError ?? "Please enter the OTP code.";
    }
    if (value.length < 4) {
      return lengthError ?? "Please enter a valid verification code.";
    }
    return null;
  }

  /// Validates a password during login (not empty and max 50 chars).
  static String? validateLoginPassword(
    String? value, {
    String? emptyError,
    String? lengthError,
  }) {
    if (value == null) return null;
    value = value.trim();
    if (value.isEmpty) {
      return emptyError ?? "Password cannot be empty.";
    }
    if (value.length > 50) {
      return lengthError ?? "Maximum 50 characters allowed.";
    }
    return null;
  }

  /// Validates a phone number with min/max length constraints.
  static String? validatePhoneNumber(
    String? value,
    int minLength,
    int maxLength, {
    String? emptyError,
    String? invalidError,
  }) {
    if (value == null) return null;
    value = value.trim().replaceAll(" ", "");

    if (value.isEmpty) {
      return emptyError ?? "Please enter a mobile number.";
    }
    if (value.length < minLength || value.length > maxLength) {
      return invalidError ?? "Please enter a valid mobile number.";
    }
    return null;
  }

  /// Validates that an email is not empty and is in correct email format.
  static String? validateEmailAddress(
    String? value, {
    String? emptyError,
    String? invalidError,
  }) {
    value = value?.trim() ?? "";
    if (value.isEmpty) {
      return emptyError ?? "Email address cannot be empty.";
    }
    if (!RegExpUtils.emailPatternRegExp.hasMatch(value)) {
      return invalidError ?? "Please enter a valid email address.";
    }
    return null;
  }

  /// Validates that a 6-digit OTP code is valid.
  static String? validateOtpCode(
    String? value, {
    String? emptyError,
    String? invalidError,
  }) {
    value = value?.trim() ?? "";
    if (value.isEmpty) {
      return emptyError ?? "OTP code cannot be empty.";
    }
    if (value.length < 6) {
      return invalidError ?? "OTP code must be at least 6 characters.";
    }
    return null;
  }

  /// Validates that a password field is not empty.
  static String? validatePasswordRequire(String? value, {String? emptyError}) {
    value = value?.trim() ?? "";
    if (value.isEmpty) {
      return emptyError ?? "Please enter your password.";
    }
    return null;
  }

  /// Validates a complex password pattern (at least 8 chars, 1 digit, 1 special char, 1 upper, 1 lower).
  static String? validatePassword(
    String? value, {
    bool isNewPasswordValidation = false,
    String? emptyError,
    String? lengthError,
    String? complexityError,
  }) {
    value = value?.trim() ?? "";
    if (value.isEmpty) {
      if (emptyError != null) return emptyError;
      return isNewPasswordValidation
          ? "Please enter your new password."
          : "Please enter your password.";
    }
    if (!RegExpUtils.passwordPatternRegExp.hasMatch(value)) {
      final errors = <String>[];
      if (value.length < 8) {
        errors.add(
          lengthError ?? "Password must be at least 8 characters long.",
        );
      }
      errors.add(
        complexityError ??
            "Password must contain uppercase, lowercase, numbers, and special characters.",
      );
      return errors.join("\n");
    }
    return null;
  }

  /// Validates confirm password (checks matching with password).
  static String? validateConfirmPassword(
    String? value,
    String password, {
    bool isChangePassword = false,
    String? emptyError,
    String? mismatchError,
  }) {
    value = value?.trim() ?? "";
    if (value.isEmpty) {
      if (emptyError != null) return emptyError;
      return isChangePassword
          ? "Please confirm your new password."
          : "Please confirm your password.";
    }
    if (password != value) {
      if (mismatchError != null) return mismatchError;
      return isChangePassword
          ? "New password and confirmation password do not match."
          : "Passwords do not match.";
    }
    return null;
  }

  /// Validates that a generic field is not empty and has at least 2 characters.
  static String? validateEmptyField(
    String? value, {
    required String fieldName,
    String? emptyError,
    String? lengthError,
  }) {
    value = value?.trim() ?? "";
    if (value.isEmpty) {
      return emptyError ?? "Please enter $fieldName.";
    }
    if (value.length < 2) {
      return lengthError ?? "$fieldName must be at least 2 characters long.";
    }
    return null;
  }

  /// Validates a field with a custom message if empty or less than 2 characters.
  static String? validateMinLengthName(
    String? value, {
    required String emptyMessage,
    String? minLengthMessage,
  }) {
    value = value?.trim() ?? "";
    if (value.isEmpty) {
      return emptyMessage;
    }
    if (value.length < 2) {
      return minLengthMessage ?? "Must be at least 2 characters.";
    }
    return null;
  }
}


class FormValidation {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    final cleanedValue = value.trim();

    final nameRegex = RegExp(r"^[A-Za-z]+(?: [A-Za-z]+)*$");

    if (!nameRegex.hasMatch(cleanedValue)) {
      return "Please enter your correct name..";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final trimmedEmail = value.trim();

    if (trimmedEmail.contains(' ')) {
      return "Email cannot contain spaces";
    }

    if (RegExp(r'[A-Z]').hasMatch(trimmedEmail)) {
      return "Email must be in lowercase";
    }

    if (RegExp(r'[^\w@.]').hasMatch(trimmedEmail)) {
      return "Email can only contain '@' and '.' as special characters";
    }

    if (RegExp(r'(\.\.|@@|@\.|\.@)').hasMatch(trimmedEmail)) {
      return "Email cannot contain repeated or adjacent '@' and '.'";
    }

    final emailRegex = RegExp(
      r'^[a-z0-9]+([._]?[a-z0-9]+)*@[a-z0-9]+\.[a-z]{2,4}$',
    );
    if (!emailRegex.hasMatch(trimmedEmail)) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }

    final password = value.trim();

    if (password.length < 8) {
      return "Password must be at least 8 characters";
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Password must include at least one uppercase letter";
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Password must include at least one lowercase letter";
    }

    if (!RegExp(r'\d').hasMatch(password)) {
      return "Password must include at least one number";
    }

    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return "Password must include at least one special character";
    }

    if (password.contains(' ')) {
      return "Password cannot contain spaces";
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Please re-enter your password";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

 
}

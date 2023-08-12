mixin ValidationMixin {
  String? validateEmail(String? value) {
    if (value?.contains('@') == false) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(value) {
    if (value!.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }
}

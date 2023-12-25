extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r'^[a-zA-Z]\w{2,14}$');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(r'^[a-zA-Z]\w{3,14}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r'^[0-9]{10}$');
    return phoneRegExp.hasMatch(this);
  }
}

String? validatorLogin({required String name}) {
  if (name.length <= 3) {
    return "Name must be longest than 3 characters";
  } else {
    return null;
  }
}

String? validatorPassword({required String password}) {
  if (password.length <= 7) {
    return "Password must be longest then 7 characters";
  } else {
    return null;
  }
}

String? validatorConfirmPassword({
  required String value,
  required String confirmPassword,
}) {
  if (value != confirmPassword) {
    return "Confirm password don'\t match with password";
  } else {
    return null;
  }
}

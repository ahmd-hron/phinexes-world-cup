String? validateOldPassword(String? value, String oldUserPassword) {
  if (value == null || value.isEmpty) {
    return 'Please Enter your old password';
  } else if (value != oldUserPassword) {
    return 'Old password is incorrect';
  } else {
    return null;
  }
}

String? validateNewPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your new password';
  } else if (value.length < 6) {
    return 'New password must have at least 6 characters';
  } else {
    return null;
  }
}

String? validatePasswordConfirm(String? value, String? newPassword) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your new password';
  } else if (value != newPassword) {
    return 'Password does not match';
  } else {
    return null;
  }
}

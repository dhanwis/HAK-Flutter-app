class Validation {
  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    }
    String pattern = r'(^[0-9]{10}$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Name';
    }
    return null;
  }

  String? _validatePincode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Pincode';
    }
    String pattern = r'^[1-9][0-9]{5}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid 6-digit PIN code';
    }
    return null;
  }

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter City';
    }
    return null;
  }

  String? _validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter State';
    }
    return null;
  }
}

final int id = 0;

class ApiLinks {
// post
  static String createUser = 'https://hak.pythonanywhere.com/auth/customer/';

  set setId(int id) {
    submitOtp = 'https://hak.pythonanywhere.com/auth/customer/$id/verify-otp/';
  }

  static String submitOtp =
      'https://hak.pythonanywhere.com/auth/customer/$id/verify-otp/';
}

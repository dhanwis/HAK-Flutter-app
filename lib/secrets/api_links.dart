class ApiLinks {
// post

  int _id = 0;

  get id => _id;
  static String createUser = 'https://hak.pythonanywhere.com/auth/customer/';

  set setId(int id) {
    _id = id;
  }
}

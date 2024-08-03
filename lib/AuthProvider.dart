class MyAuthProvider {
  static final MyAuthProvider _instance = MyAuthProvider._internal();

  factory MyAuthProvider() {
    return _instance;
  }

  MyAuthProvider._internal();

  late String userType; // Marking as late

  // Method to update user type
  void setUserType(String type) {
    userType = type;
  }

  // Method to check if the logged-in user is a doctor
  bool isDoctor() {
    return userType == 'doctor';
  }
}

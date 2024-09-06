// ignore_for_file: constant_identifier_names

class UserLoggedIn {
  String role;

  UserLoggedIn({this.role = ""});

  void setRole(String role) {
    this.role = role;
  }

  bool isAdmin() {
    return role == ROLES.ROLE_ADMIN.name;
  }
}

enum ROLES { ROLE_ADMIN, ROLE_USER }

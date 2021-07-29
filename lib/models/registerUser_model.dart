class RegisUser {
  final int roleId;
  final String name;
  final String email;
  final String pass;

  RegisUser ({
    required this.roleId,
    required this.name,
    required this.email,
    required this.pass,
  });

  Map<String, dynamic> toJson() {
    return {
      'Role_ID': roleId,
      'Name' : name,
      'Email' : email,
      'Password' : pass,
    };
  }
}
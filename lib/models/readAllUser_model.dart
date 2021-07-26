class AllUserPack {
  final String message;
  final List<AllUser> data;

  AllUserPack({
    required this.message, required this.data
  });

  factory AllUserPack.fromJson(Map<String, dynamic> json) {
    List<AllUser> _temp = [];
    for (Map<String, dynamic> role in json['data']) {
      _temp.add(AllUser.fromJson(role));
    }
    return AllUserPack(
      message: json['message'],
      data: _temp
    );
  }
}


class AllUser {
  final int userId;
  final int roleId;
  final String name;
  final String email;
  final String firebaseUID;

  AllUser({
    required this.userId,
    required this.roleId,
    required this.name,
    required this.email,
    required this.firebaseUID
    
  });

  factory AllUser.fromJson(Map<String, dynamic> json) {
    return AllUser(
      userId: json['User_ID'] as int,
      roleId: json['Role_ID'] as int,
      name: json['Name'] as String,
      email: json['Email'] as String,
      firebaseUID: json['Firebase_UID'] as String,
    );
  }
}

class ResponseGagal {
  final String message;
  final String error_key;
  final String error_message;
  final String error_data;

  ResponseGagal({
    required this.message,
    required this.error_key,
    required this.error_message,
    required this.error_data,
  });

  factory ResponseGagal.fromJson(Map<String, dynamic> json) {
    return ResponseGagal (
      message: json['message'] as String,
      error_key: json['error_key'] as String,
      error_message: json['error_message'] as String,
      error_data: json['error_data'] as String,
    );
  }
}
class ReadUserFirebaseUID {
  final String message;
  final UserData data;

  ReadUserFirebaseUID({
    required this.message, required this.data
  });

  factory ReadUserFirebaseUID.fromJson(Map<String, dynamic> json) {
    UserData userData = UserData.fromJson(json['data']);
    return ReadUserFirebaseUID(
      message: json['message'],
      data: userData,
    );
  }
}

class UserData {
  final int userId;
  final int roleId;
  final String name;
  final String email;
  final String firebaseUid;

  UserData({
    required this.userId,
    required this.roleId,
    required this.name,
    required this.email,
    required this.firebaseUid,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['User_ID'] as int,
      roleId: json['Role_ID'] as int,
      name: json['Name'] as String,
      email: json['Email'] as String,
      firebaseUid: json['Firebase_UID'] as String,
    );
  }
}
class Body {
  final int roleId;
  final String name;
  final String email;
  final String pass;

  Body ({
    required this.roleId,
    required this.name,
    required this.email,
    required this.pass,
  });

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body (
      roleId: json['Role_ID'] as int,
      name: json['Name'] as String,
      email: json['Email'] as String,
      pass: json['Password'] as String
    );
  }
}

class ResponseBerhasil {
  final String message;
  final String data;

  ResponseBerhasil ({
    required this.message,
    required this.data,
  });

  factory ResponseBerhasil.fromJson(Map<String, dynamic> json) {
    return ResponseBerhasil (
      message: json['message'] as String,
      data: json['data'] as String,
    );
  }
}

class ResponseGagal {
  final String message;
  final String error_key;
  final String error_message;
  final String error_data;

  ResponseGagal ({
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
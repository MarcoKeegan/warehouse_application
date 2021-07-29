abstract class PostResponse {
  final String message;
  PostResponse({required this.message});
}

class ResponseGagal extends PostResponse {
  final String? error_key;
  final String? error_message;
  final error_data;

  ResponseGagal ({
    required String message,
    this.error_key,
    this.error_message,
    this.error_data,
  }) : super(message:  message);

  factory ResponseGagal.fromJson(Map<String, dynamic> json) {
    return ResponseGagal (
      message: json['message'] as String,
      error_key: json['error_key'] as String,
      error_message: json['error_message'] as String,
      error_data: json['error_data'] as String,
    );
  }
}

class ResponseBerhasil extends PostResponse {
  ResponseBerhasil({required String message}) : super(message: message);
 
  factory ResponseBerhasil.fromJson(Map<String, dynamic> json) {
    return ResponseBerhasil (
      message: json['message'] as String,
    );
  }
}

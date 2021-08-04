abstract class PostResponse {
  final String message;
  PostResponse({required this.message});
}

class ResponseGagal extends PostResponse {
  final String? errorkey;
  final String? errormessage;
  final errordata;

  ResponseGagal({
    required String message,
    this.errorkey,
    this.errormessage,
    this.errordata,
  }) : super(message: message);

  factory ResponseGagal.fromJson(Map<String, dynamic> json) {
    return ResponseGagal(
      message: json['message'],
      errorkey: json['error_key'],
      errormessage: json['error_message'],
      errordata: json['error_data'],
    );
  }
}

class ResponseBerhasil extends PostResponse {
  ResponseBerhasil({required String message}) : super(message: message);

  factory ResponseBerhasil.fromJson(Map<String, dynamic> json) {
    return ResponseBerhasil(
      message: json['message'],
    );
  }
}

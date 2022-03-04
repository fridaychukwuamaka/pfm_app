
class ApiResponse {
  final int? code;
  final dynamic data;
  final bool isSuccessful;
  String? message;
  String? token;

  ApiResponse(
      {this.code,
      this.message,
      this.data,
      required this.isSuccessful,
      this.token});

  
}

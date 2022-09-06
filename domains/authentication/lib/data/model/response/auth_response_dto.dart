class AuthResponseDto {
  AuthResponseDto({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  final bool? status;
  final int? code;
  final String? message;
  final AuthDataResponse? data;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      AuthResponseDto(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: AuthDataResponse.fromJson(json["data"]),
      );
}

class AuthDataResponse {
  AuthDataResponse({
    this.token,
  });

  final String? token;

  factory AuthDataResponse.fromJson(Map<String, dynamic> json) =>
      AuthDataResponse(
        token: json["token"],
      );
}

class LogoutResponse {
  final bool logged;

  LogoutResponse({required this.logged});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      LogoutResponse(logged: json['data']);
}

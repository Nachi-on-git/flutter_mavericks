class HttpResponses {
  bool? status;
  String? message;
  dynamic data;

  HttpResponses({this.status, this.message, this.data});

  factory HttpResponses.fromJson(Map<String, dynamic> json) {
    return HttpResponses(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['body'] ?? '',
    );
  }
}

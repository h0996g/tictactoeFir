class RegisterAndLoginModel {
  bool? status;
  String? message;
  String? token;
  RegisterAndLoginModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
  }
}

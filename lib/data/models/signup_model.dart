class Signup {
  String? name;
  String? email;
  String? password;
  String? confirmPassword;

  Signup({this.name, this.email, this.password, this.confirmPassword});

  Signup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}

class SignupResponse {
  String? message;
  int? userId;

  SignupResponse({this.message, this.userId});

  SignupResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_id'] = this.userId;
    return data;
  }
}
class LoginResponseModel {
  String message;
  String token;
  LoginUserResponseModel user;

  LoginResponseModel({this.message, this.token, this.user});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null
        ? new LoginUserResponseModel.fromJson(json['user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class LoginUserResponseModel {
  String id;
  String name;
  String email;
  String image;
  String role;

  LoginUserResponseModel(
      {this.id, this.name, this.email, this.image, this.role});

  LoginUserResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['role'] = this.role;
    return data;
  }
}

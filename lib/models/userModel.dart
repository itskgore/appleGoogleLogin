enum LoginType { apple, google, normal }

class UserModel {
  String id;
  String firstName;
  String lastName;
  String profilePicture;
  String loginType;
  String email;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.profilePicture,
      this.loginType,
      this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicture = json['profilePicture'];
    loginType = json['loginType'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profilePicture'] = this.profilePicture;
    data['loginType'] = this.loginType;
    data['email'] = this.email;
    return data;
  }
}

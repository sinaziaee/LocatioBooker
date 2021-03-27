class User {
  String firstName, lastName, phone, email, password, country, token;

  User({this.firstName, this.lastName, this.phone, this.email, this.password,
      this.country, this.token});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['token'] = this.token;
    return data;
  }
}

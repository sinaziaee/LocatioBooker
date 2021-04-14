class User {
  String firstName, lastName, phone, email, password, country, token, nationalCode, image, gender;

  User({this.firstName, this.lastName, this.phone, this.email, this.password,
      this.country, this.token, this.nationalCode, this.image, this.gender});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    country = json['country'] ?? 'Iran';
    nationalCode = json['national_code'];
    phone = json['phone_number'];
    email = json['email'];
    password = json['password'];
    token = 'Token ${json['token']}';
    image = json['image'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone_number'] = this.phone;
    data['country'] = this.country;
    data['national_code'] = this.country;
    data['token'] = this.token;
    data['image'] = this.image;
    data['gender'] = this.gender;
    return data;
  }
}

class User {
  String firstName,
      lastName,
      phone,
      email,
      password,
      country,
      token,
      nationalCode,
      image,
      bio,
      gender;

  User(
      {this.firstName,
      this.lastName,
      this.phone,
      this.bio,
      this.email,
      this.password,
      this.country,
      this.token,
      this.nationalCode,
      this.image,
      this.gender});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    country = json['country'] ?? 'Iran';
    nationalCode = json['national_code'];
    phone = json['phone_number'];
    email = json['email'];
    password = json['password'];
    token = 'Token ${json['token']}';
    image = json['base64'];
    bio = json['bio'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.firstName != null && this.firstName.length != 0) {
      data['first_name'] = this.firstName;
    }
    if (this.lastName != null && this.lastName.length != 0) {
      data['last_name'] = this.lastName;
    }
    if (this.password != null && this.password.length != 0) {
      data['password'] = this.password;
    }
    if (this.email != null && this.email.length != 0) {
      data['email'] = this.email;
    }
    if (this.phone != null && this.phone.length != 0) {
      data['phone_number'] = this.phone;
    }
    if (this.bio != null && this.bio.length != 0) {
      data['bio'] = this.bio;
    }
    if (this.country != null && this.country.length != 0) {
      data['country'] = this.country;
    }
    if (this.nationalCode != null && this.nationalCode.length != 0) {
      data['national_code'] = this.country;
    }
    if (this.gender != null && this.gender.length != 0) {
      data['gender'] = this.gender;
    }
    if (this.token != null && this.token.length != 0) {
      data['token'] = this.token;
    }
    if (this.image != null && this.image.length != 0) {
      data['base64'] = this.image;
    }
    return data;
  }
}

class SearchModel {
  String name, country, state, city, url;
  int pricePerNight;
  double rate;

  SearchModel({
    this.name,
    this.country,
    this.state,
    this.city,
    this.url,
    this.rate,
    this.pricePerNight,
  });

  SearchModel.fromMap(Map<String, dynamic> map){
    name = map['name'];
    country = map['country'];
    state = map['state'];
    city = map['city'];
    pricePerNight = map['price_per_night'];
    rate = map['rate'];
    url = map['default_image_url'];
  }

  printUser() {
    print('name: $name');
    print('country: $country');
    print('state: $state');
    print('city: $city');
    print('rate: $rate');
    print('price_per_night: $pricePerNight');
    print('default_image_url: $url');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null && this.name.length != 0) {
      data['name'] = this.name;
    }
    if (this.country != null && this.country.length != 0) {
      data['country'] = this.country;
    }
    if (this.state != null && this.state.length != 0) {
      data['state'] = this.state;
    }
    if (this.city != null && this.city.length != 0) {
      data['city'] = this.city;
    }
    if (this.pricePerNight != null) {
      data['price_per_night'] = this.pricePerNight;
    }
    if (this.pricePerNight != null) {
      data['default_image_url'] = this.url;
    }
    if (this.country != null && this.country.length != 0) {
      data['country'] = this.country;
    }
    if (this.country != null && this.country.length != 0) {
      data['rate'] = this.rate;
    }
    return data;
  }

}

class SearchModel {
  String name, country, state, city;
  int pricePerNight;
  List<String> images;

  SearchModel({
    this.name,
    this.country,
    this.images,
    this.state,
    this.city,
    this.pricePerNight,
  });

  SearchModel.fromMap(Map<String, dynamic> map){
    name = map['name'];
    country = map['country'];
    state = map['state'];
    city = map['city'];
    pricePerNight = map['price_per_night'];
    images = map['images'];
  }

  printUser() {
    print('name: $name');
    print('country: $country');
    print('state: $state');
    print('city: $city');
    print('price_per_night: $pricePerNight');
    print('phone: $images');
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
    if (this.images != null && this.images.length != 0) {
      data['images'] = this.images;
    }
    if (this.country != null && this.country.length != 0) {
      data['country'] = this.country;
    }
    return data;
  }

}

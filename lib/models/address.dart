class Address {
  String place;
  String district;
  String city;
  String postalCode;
  String fererativeUnit;

  @override
  String toString() {
    return 'Address{place: $place, district: $district, city: $city, postalCode: $postalCode, fererativeUnit: $fererativeUnit}';
  }

  Address(
      {this.place,
      this.district,
      this.city,
      this.postalCode,
      this.fererativeUnit});
}

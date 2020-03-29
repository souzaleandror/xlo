import 'package:xlo/models/address.dart';

class Ad {
  List<dynamic> images;
  String title;
  String description;
  Address address;
  num price;
  bool hidePhone;
  DateTime dateCreated = DateTime.now();

  @override
  String toString() {
    return 'Ad{images: $images, title: $title, description: $description, address: $address, price: $price, hidePhone: $hidePhone}';
  }
}

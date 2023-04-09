import 'package:cloud_firestore/cloud_firestore.dart';

class Userdb {
  String id;
  final String name;
  final int age;
  final int bedrooms;
  final int bathrooms;
  final String furnished;
  final int parking;
  final String flatno;
  final String street;
  final String city;
  final String area;
  final String state;
  final int mobile;
  final String email;
  final String propType;
  final int rent;
  final int maintenance;
  final double sqft;
  final double carpet;
  final String country;
  final String description;
  final int pincode;
  final String landmark;
  final DateTime availableDate;

  final bool isfavorite;
  final List<String> multipleImages;

  Userdb({
    this.id = "",
    required this.name,
    required this.age,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.carpet,
    required this.city,
    required this.description,
    required this.email,
    required this.flatno,
    required this.furnished,
    required this.landmark,
    required this.maintenance,
    required this.mobile,
    required this.parking,
    required this.pincode,
    required this.propType,
    required this.rent,
    required this.sqft,
    required this.state,
    required this.street,
    required this.country,
    required this.availableDate,
    required this.isfavorite,
    required this.multipleImages,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'bedrooms': bedrooms,
        'bathrooms': bathrooms,
        'parking': parking,
        'furnished': furnished,
        'sqft': sqft,
        'carpet': carpet,
        'description': description,
        'flatno': flatno,
        'street': street,
        'area': area,
        'city': city,
        'state': state,
        'pincode': pincode,
        'landmark': landmark,
        'maintenance': maintenance,
        'type': propType,
        'email': email,
        'mobile': mobile,
        'rent': rent,
        'date': availableDate,
        'country': country,
        'isfavorite': isfavorite,
        'multipleImages': multipleImages,
      };

  static Userdb fromJson(Map<String, dynamic> json) => Userdb(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        bedrooms: json['bedrooms'],
        bathrooms: json['bathrooms'],
        parking: json['parking'],
        furnished: json['furnished'],
        sqft: json['sqft'],
        carpet: json['carpet'],
        description: json['description'],
        flatno: json['flatno'],
        street: json['street'],
        area: json['area'],
        city: json['city'],
        state: json['state'],
        pincode: json['pincode'],
        landmark: json['landmark'],
        maintenance: json['maintenance'],
        propType: json['type'],
        email: json['email'],
        mobile: json['mobile'],
        rent: json['rent'],
        country: json['country'],
        isfavorite: json['isfavorite'],
        multipleImages: json['multipleImages'],
        availableDate: (json['date'] as Timestamp).toDate(),
      );
}

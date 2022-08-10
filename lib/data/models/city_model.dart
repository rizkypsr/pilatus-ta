import 'package:pilatus/domain/entities/city.dart';

class CityModel {
  final String cityId;
  final String cityName;
  final String type;
  final String postalCode;

  CityModel(
      {required this.cityId,
      required this.cityName,
      required this.type,
      required this.postalCode});

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        cityId: json['city_id'],
        cityName: json['city_name'],
        type: json['type'],
        postalCode: json['postal_code'],
      );

  City toEntity() {
    return City(
        cityId: cityId, cityName: cityName, type: type, postalCode: postalCode);
  }
}

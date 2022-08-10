import 'package:pilatus/data/models/city_model.dart';

class CityResponse {
  final List<CityModel> cities;

  CityResponse({required this.cities});

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        cities: List<CityModel>.from((json["rajaongkir"]['results'] as List)
            .map((x) => CityModel.fromJson(x))),
      );
}

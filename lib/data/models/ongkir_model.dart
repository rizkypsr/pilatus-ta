import 'package:pilatus/data/models/city_model.dart';
import 'package:pilatus/data/models/cost_model.dart';
import 'package:pilatus/domain/entities/ongkir.dart';

class OngkirModel {
  final CityModel origin;
  final CityModel destination;
  final List<CostModel> costs;

  OngkirModel({
    required this.origin,
    required this.destination,
    required this.costs,
  });

  factory OngkirModel.fromJson(Map<String, dynamic> json) => OngkirModel(
        origin: CityModel.fromJson(json['origin_details']),
        destination: CityModel.fromJson(json['destination_details']),
        costs: List<CostModel>.from((json["results"][0]['costs'] as List)
            .map((x) => CostModel.fromJson(x))),
      );

  Ongkir toEntity() {
    return Ongkir(
      origin: origin.toEntity(),
      destination: destination.toEntity(),
      costs: costs.map((cost) => cost.toEntity()).toList(),
    );
  }
}

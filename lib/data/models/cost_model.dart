import 'package:pilatus/domain/entities/cost.dart';

class CostModel {
  final String service;
  final String description;
  final int value;
  final String etd;

  CostModel(
      {required this.service,
      required this.description,
      required this.value,
      required this.etd});

  factory CostModel.fromJson(Map<String, dynamic> json) => CostModel(
        service: json['service'],
        description: json['description'],
        value: json['cost'][0]['value'],
        etd: json['cost'][0]['etd'],
      );

  Cost toEntity() {
    return Cost(
        service: service, description: description, value: value, etd: etd);
  }
}

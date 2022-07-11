import 'package:pilatus/domain/entities/city.dart';
import 'package:pilatus/domain/entities/shipping.dart';

class ShippingModel {
  final int id;
  final String? resi;
  final String address;
  final String province;
  final String city;
  final String postalCode;
  final String courier;
  final String service;
  final int cost;
  final String updatedAt;

  ShippingModel(
      {required this.id,
      this.resi,
      required this.address,
      required this.province,
      required this.city,
      required this.postalCode,
      required this.courier,
      required this.service,
      required this.cost,
      required this.updatedAt});

  factory ShippingModel.fromJson(Map<String, dynamic> json) => ShippingModel(
        id: json['id'],
        address: json['address'],
        province: json['province'],
        postalCode: json['postal_code'],
        city: json['city'],
        cost: json['cost'],
        courier: json['courier'],
        service: json['service'],
        updatedAt: json['updated_at'],
        resi: json['resi'],
      );

  Shipping toEntity() {
    return Shipping(
        id: id,
        address: address,
        province: province,
        city: city,
        postalCode: postalCode,
        courier: courier,
        service: service,
        cost: cost,
        updatedAt: updatedAt,
        resi: resi);
  }
}

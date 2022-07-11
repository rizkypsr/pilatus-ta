import 'package:pilatus/data/models/city_model.dart';
import 'package:pilatus/data/models/shipping_model.dart';

class ShippingResponse {
  final ShippingModel shipping;

  ShippingResponse({required this.shipping});

  factory ShippingResponse.fromJson(Map<String, dynamic> json) =>
      ShippingResponse(
        shipping: ShippingModel.fromJson(json['shipping']),
      );
}

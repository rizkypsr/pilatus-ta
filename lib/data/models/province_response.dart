import 'package:pilatus/data/models/province_model.dart';

class ProvinceResponse {
  final List<ProvinceModel> provinces;

  ProvinceResponse({required this.provinces});

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) =>
      ProvinceResponse(
        provinces: List<ProvinceModel>.from(
            (json["rajaongkir"]['results'] as List)
                .map((x) => ProvinceModel.fromJson(x))),
      );
}

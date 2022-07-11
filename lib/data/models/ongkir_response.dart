import 'package:pilatus/data/models/ongkir_model.dart';

class OngkirResponse {
  final OngkirModel ongkir;

  OngkirResponse({required this.ongkir});

  factory OngkirResponse.fromJson(Map<String, dynamic> json) =>
      OngkirResponse(ongkir: OngkirModel.fromJson(json['rajaongkir']));
}

import 'package:pilatus/data/models/cost_model.dart';
import 'package:pilatus/data/models/province_model.dart';

class CostResponse {
  final List<CostModel> costs;

  CostResponse({required this.costs});

  factory CostResponse.fromJson(Map<String, dynamic> json) => CostResponse(
        costs: List<CostModel>.from((json["rajaongkir"]['results'] as List)
            .map((x) => ProvinceModel.fromJson(x))),
      );
}

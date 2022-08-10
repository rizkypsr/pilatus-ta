import 'package:pilatus/domain/entities/province.dart';

class ProvinceModel {
  final String provinceId;
  final String provinceName;

  ProvinceModel({required this.provinceId, required this.provinceName});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        provinceId: json['province_id'],
        provinceName: json['province'],
      );

  Province toEntity() {
    return Province(provinceId: provinceId, provinceName: provinceName);
  }
}

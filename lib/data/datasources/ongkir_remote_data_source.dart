import 'dart:convert';

import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/models/city_model.dart';
import 'package:pilatus/data/models/city_response.dart';
import 'package:pilatus/data/models/ongkir_model.dart';
import 'package:pilatus/data/models/ongkir_response.dart';
import 'package:pilatus/data/models/province_model.dart';
import 'package:http/http.dart' as http;
import 'package:pilatus/data/models/province_response.dart';
import 'package:pilatus/domain/entities/ongkir.dart';

abstract class OngkirRemoteDataSource {
  Future<List<ProvinceModel>> getProvinces();
  Future<List<CityModel>> getCities(String provinceId);
  Future<OngkirModel> getCosts(String origin, String destination, int weight);
}

class OngkirRemoteDataSourceImpl implements OngkirRemoteDataSource {
  final http.Client client;

  OngkirRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProvinceModel>> getProvinces() async {
    final response =
        await client.get(Uri.parse('$rajaOngkirUrl/province'), headers: {
      'key': rajaOngkirApiKey,
    });

    if (response.statusCode == 200) {
      return ProvinceResponse.fromJson(jsonDecode(response.body)).provinces;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CityModel>> getCities(String provinceId) async {
    final response = await client
        .get(Uri.parse('$rajaOngkirUrl/city?province=$provinceId'), headers: {
      'key': rajaOngkirApiKey,
    });

    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).cities;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OngkirModel> getCosts(
      String origin, String destination, int weight) async {
    final body = json.encode({
      'origin': origin,
      'destination': destination,
      'weight': weight,
      'courier': 'jne'
    });

    final response = await client.post(Uri.parse('$rajaOngkirUrl/cost'),
        headers: {
          "Content-Type": "application/json",
          'key': rajaOngkirApiKey,
        },
        body: body);

    if (response.statusCode == 200) {
      return OngkirResponse.fromJson(jsonDecode(response.body)).ongkir;
    } else {
      throw ServerException();
    }
  }
}

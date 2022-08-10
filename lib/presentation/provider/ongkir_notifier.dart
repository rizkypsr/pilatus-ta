import 'package:flutter/material.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/city.dart';
import 'package:pilatus/domain/entities/cost.dart';
import 'package:pilatus/domain/entities/ongkir.dart';
import 'package:pilatus/domain/entities/province.dart';
import 'package:pilatus/domain/usecases/get_cities.dart';
import 'package:pilatus/domain/usecases/get_costs.dart';
import 'package:pilatus/domain/usecases/get_provinces.dart';

class OngkirNotifier extends ChangeNotifier {
  var _provinces = <Province>[];
  List<Province> get provinces => _provinces;

  var _cities = <City>[];
  List<City> get cities => _cities;

  var _ongkir = null;
  Ongkir get ongkir => _ongkir;

  RequestState _provinceState = RequestState.Empty;
  RequestState get provinceState => _provinceState;

  RequestState _cityState = RequestState.Empty;
  RequestState get cityState => _cityState;

  RequestState _ongkirState = RequestState.Empty;
  RequestState get ongkirState => _ongkirState;

  Province _provinceValue = Province();
  Province get provinceValue => _provinceValue;

  City _cityValue = City();
  City get cityValue => _cityValue;

  Cost _ongkirValue = Cost();
  Cost get ongkirValue => _ongkirValue;

  String _provinceMessage = '';
  String get provinceMessage => _provinceMessage;

  String _cityMessage = '';
  String get cityMessage => _cityMessage;

  String _ongkirMessage = '';
  String get ongkirMessage => _ongkirMessage;

  final GetProvinces getProvinces;
  final GetCities getCities;
  final GetCosts getCosts;

  OngkirNotifier(
      {required this.getProvinces,
      required this.getCities,
      required this.getCosts});

  changeProvinceValue(Province value) {
    _provinceValue = value;
    notifyListeners();

    fetchCities(_provinceValue.provinceId!);
  }

  changeCityValue(City value) {
    _cityValue = value;
    notifyListeners();

    fetchCosts('501', _cityValue.cityId!, 100);
  }

  changeOngkirValue(Cost value) {
    _ongkirValue = value;
    notifyListeners();
  }

  Future<void> fetchProvinces() async {
    _provinceState = RequestState.Loading;
    notifyListeners();

    final result = await getProvinces.execute();

    result.fold(
      (failure) {
        _provinceState = RequestState.Error;
        _provinceMessage = failure.message;
        notifyListeners();
      },
      (provincesData) {
        _provinceState = RequestState.Loaded;
        _provinces = provincesData;
        _provinceValue = provincesData[0];
        notifyListeners();
      },
    );
  }

  Future<void> fetchCities(String provinceId) async {
    _cityState = RequestState.Loading;
    notifyListeners();

    final result = await getCities.execute(provinceId);

    result.fold(
      (failure) {
        _cityState = RequestState.Error;
        _cityMessage = failure.message;
        notifyListeners();
      },
      (citiesData) {
        _cityState = RequestState.Loaded;
        _cities = citiesData;
        _cityValue = citiesData[0];
        notifyListeners();
      },
    );
  }

  Future<void> fetchCosts(String origin, String destination, int weight) async {
    _ongkirState = RequestState.Loading;
    notifyListeners();

    final result = await getCosts.execute(origin, destination, weight);

    result.fold(
      (failure) {
        _ongkirState = RequestState.Error;
        _ongkirMessage = failure.message;
        notifyListeners();
      },
      (ongkirData) {
        _ongkirState = RequestState.Loaded;
        _ongkir = ongkirData;
        _ongkirValue = ongkirData.costs[0];
        notifyListeners();
      },
    );
  }
}

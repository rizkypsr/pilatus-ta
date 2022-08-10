import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/city.dart';
import 'package:pilatus/domain/repositories/ongkir_repository.dart';

class GetCities {
  final OngkirRepository repository;

  GetCities(this.repository);

  Future<Either<Failure, List<City>>> execute(String provinceId) {
    return repository.getCities(provinceId);
  }
}

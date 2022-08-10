import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/province.dart';
import 'package:pilatus/domain/repositories/ongkir_repository.dart';

class GetProvinces {
  final OngkirRepository repository;

  GetProvinces(this.repository);

  Future<Either<Failure, List<Province>>> execute() {
    return repository.getProvinces();
  }
}

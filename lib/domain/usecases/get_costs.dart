import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/ongkir.dart';
import 'package:pilatus/domain/repositories/ongkir_repository.dart';

class GetCosts {
  final OngkirRepository repository;

  GetCosts(this.repository);

  Future<Either<Failure, Ongkir>> execute(
      String origin, String destination, int weight) {
    return repository.getCosts(origin, destination, weight);
  }
}

import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/order.dart';
import 'package:pilatus/domain/repositories/order_repository.dart';

class GetOrder {
  final OrderRepository repository;

  GetOrder(this.repository);

  Future<Either<Failure, Orders>> execute(String id) {
    return repository.getOrder(id);
  }
}

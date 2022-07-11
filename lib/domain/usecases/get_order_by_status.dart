import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/order.dart';
import 'package:pilatus/domain/repositories/order_repository.dart';

class GetOrderByStatus {
  final OrderRepository repository;

  GetOrderByStatus(this.repository);

  Future<Either<Failure, List<Orders>>> execute(String status) {
    return repository.getOrderByStatus(status);
  }
}

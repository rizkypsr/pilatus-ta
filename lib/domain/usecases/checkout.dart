import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/order.dart';
import 'package:pilatus/domain/entities/shipping.dart';
import 'package:pilatus/domain/repositories/order_repository.dart';

class Checkout {
  final OrderRepository repository;

  Checkout(this.repository);

  Future<Either<Failure, Orders>> execute(Shipping shipping, int cartId) {
    return repository.checkout(shipping, cartId);
  }
}

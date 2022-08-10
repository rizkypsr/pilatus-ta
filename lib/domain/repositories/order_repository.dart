import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/order.dart';
import 'package:pilatus/domain/entities/shipping.dart';

abstract class OrderRepository {
  Future<Either<Failure, Orders>> checkout(Shipping shipping, int cartId);
  Future<Either<Failure, Orders>> getOrder(String id);
  Future<Either<Failure, List<Orders>>> getOrderByStatus(String status);
}

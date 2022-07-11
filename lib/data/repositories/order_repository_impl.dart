import 'dart:io';

import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/datasources/order_remote_data_source.dart';
import 'package:pilatus/domain/entities/order.dart';
import 'package:pilatus/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatus/domain/entities/shipping.dart';
import 'package:pilatus/domain/repositories/order_repository.dart';

class OrderRepositoyImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoyImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Orders>> checkout(
      Shipping shipping, int cartId) async {
    try {
      final result = await remoteDataSource.checkout(shipping, cartId);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Orders>>> getOrderByStatus(String status) async {
    try {
      final result = await remoteDataSource.getOrderByStatus(status);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Orders>> getOrder(String id) async {
    try {
      final result = await remoteDataSource.getOrder(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}

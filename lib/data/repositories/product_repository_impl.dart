import 'dart:io';

import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/datasources/product_remote_data_source.dart';
import 'package:pilatus/domain/entities/product.dart';
import 'package:pilatus/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatus/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final result = await remoteDataSource.getProducts();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductByCategory(
      int categoryId) async {
    try {
      final result = await remoteDataSource.getProductByCategory(categoryId);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}

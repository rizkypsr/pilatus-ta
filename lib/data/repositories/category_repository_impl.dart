import 'dart:io';

import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/datasources/category_remote_data_source.dart';
import 'package:pilatus/domain/entities/category.dart';
import 'package:pilatus/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatus/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final result = await remoteDataSource.getCategories();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}

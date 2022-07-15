import 'dart:io';

import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/datasources/user_remote_data_source.dart';
import 'package:pilatus/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatus/domain/entities/user.dart';
import 'package:pilatus/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final result = await remoteDataSource.getUser();
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, User>> changeUser(String name) async {
    try {
      final result = await remoteDataSource.changeUser(name);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}

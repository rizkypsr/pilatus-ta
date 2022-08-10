import 'dart:io';

import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/datasources/auth_remote_data_source.dart';
import 'package:pilatus/domain/entities/auth.dart';
import 'package:pilatus/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatus/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Auth>> login(String email, String password) async {
    try {
      final result = await remoteDataSource.login(email, password);
      return Right(result.toEntity());
    } on AuthenticationException {
      return Left(AuthenticationFailure('Email atau password salah'));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Auth>> register(
      String name, String email, String password) async {
    try {
      final result = await remoteDataSource.register(name, email, password);
      return Right(result.toEntity());
    } on AuthenticationException {
      return Left(AuthenticationFailure('Email sudah terdaftar'));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await remoteDataSource.logout();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}

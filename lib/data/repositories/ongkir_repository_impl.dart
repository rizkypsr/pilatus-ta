import 'dart:io';

import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/datasources/ongkir_remote_data_source.dart';
import 'package:pilatus/domain/entities/province.dart';
import 'package:pilatus/domain/entities/ongkir.dart';
import 'package:pilatus/domain/entities/city.dart';
import 'package:pilatus/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatus/domain/repositories/ongkir_repository.dart';

class OngkirRepositoryImpl implements OngkirRepository {
  final OngkirRemoteDataSource remoteDataSource;

  OngkirRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Province>>> getProvinces() async {
    try {
      final result = await remoteDataSource.getProvinces();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<City>>> getCities(String provinceId) async {
    try {
      final result = await remoteDataSource.getCities(provinceId);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Ongkir>> getCosts(
      String origin, String destination, int weight) async {
    try {
      final result =
          await remoteDataSource.getCosts(origin, destination, weight);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/cart_item.dart';
import 'package:pilatus/domain/entities/city.dart';
import 'package:pilatus/domain/entities/ongkir.dart';
import 'package:pilatus/domain/entities/province.dart';

abstract class OngkirRepository {
  Future<Either<Failure, List<Province>>> getProvinces();
  Future<Either<Failure, List<City>>> getCities(String provinceId);
  Future<Either<Failure, Ongkir>> getCosts(
      String origin, String destination, int weight);
}

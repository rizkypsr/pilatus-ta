import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/repositories/cart_repository.dart';

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<Either<Failure, String>> execute(int productId) {
    return repository.addToCart(productId);
  }
}

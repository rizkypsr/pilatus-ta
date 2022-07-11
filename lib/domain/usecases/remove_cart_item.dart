import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/repositories/cart_repository.dart';

class RemoveCartItem {
  final CartRepository repository;

  RemoveCartItem(this.repository);

  Future<Either<Failure, String>> execute(int cartItemId) {
    return repository.removeCart(cartItemId);
  }
}

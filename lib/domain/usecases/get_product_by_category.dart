import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/product.dart';
import 'package:pilatus/domain/repositories/product_repository.dart';

class GetProductByCategory {
  final ProductRepository repository;

  GetProductByCategory(this.repository);

  Future<Either<Failure, List<Product>>> execute(int categoryId) {
    return repository.getProductByCategory(categoryId);
  }
}

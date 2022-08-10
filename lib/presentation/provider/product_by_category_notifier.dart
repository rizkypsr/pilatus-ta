import 'package:flutter/material.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/product.dart';
import 'package:pilatus/domain/usecases/get_product_by_category.dart';

class ProductByCategoryNotifier extends ChangeNotifier {
  var _products = <Product>[];
  List<Product> get products => _products;

  RequestState _productsState = RequestState.Empty;
  RequestState get productsState => _productsState;

  String _message = '';
  String get message => _message;

  ProductByCategoryNotifier({required this.getProductByCategory});

  final GetProductByCategory getProductByCategory;

  Future<void> fetchProducts(int categoryId) async {
    _productsState = RequestState.Loading;
    notifyListeners();

    final result = await getProductByCategory.execute(categoryId);
    result.fold(
      (failure) {
        _productsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (productsData) {
        _productsState = RequestState.Loaded;
        _products = productsData;
        notifyListeners();
      },
    );
  }
}

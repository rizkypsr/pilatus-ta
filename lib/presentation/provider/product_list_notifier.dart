import 'package:flutter/material.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/product.dart';
import 'package:pilatus/domain/usecases/get_products.dart';

class ProductListNotifier extends ChangeNotifier {
  var _products = <Product>[];
  List<Product> get products => _products;

  RequestState _productsState = RequestState.Empty;
  RequestState get productsState => _productsState;

  String _message = '';
  String get message => _message;

  ProductListNotifier({required this.getProducts});

  final GetProducts getProducts;

  Future<void> fetchProducts() async {
    _productsState = RequestState.Loading;
    notifyListeners();

    final result = await getProducts.execute();
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

import 'package:flutter/material.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/category.dart';
import 'package:pilatus/domain/entities/product.dart';
import 'package:pilatus/domain/usecases/get_categories.dart';
import 'package:pilatus/domain/usecases/get_products.dart';

class CategoryNotifier extends ChangeNotifier {
  var _categories = <Category>[];
  List<Category> get categories => _categories;

  RequestState _categoriesState = RequestState.Empty;
  RequestState get categoriesState => _categoriesState;

  String _message = '';
  String get message => _message;

  CategoryNotifier({required this.getCategories});

  final GetCategories getCategories;

  Future<void> fetchCategories() async {
    _categoriesState = RequestState.Loading;
    notifyListeners();

    final result = await getCategories.execute();
    result.fold(
      (failure) {
        _categoriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (categoriesData) {
        _categoriesState = RequestState.Loaded;
        _categories = categoriesData;
        notifyListeners();
      },
    );
  }
}

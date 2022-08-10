import 'package:flutter/material.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/order.dart';
import 'package:pilatus/domain/usecases/get_order_by_status.dart';

class OrderListNotifier extends ChangeNotifier {
  var _orders = <Orders>[];
  List<Orders> get orders => _orders;

  RequestState _ordersState = RequestState.Empty;
  RequestState get ordersState => _ordersState;

  String _message = '';
  String get message => _message;

  OrderListNotifier({required this.getOrderByStatus});

  final GetOrderByStatus getOrderByStatus;

  Future<void> fetchOrders(String status) async {
    _ordersState = RequestState.Loading;
    notifyListeners();

    final result = await getOrderByStatus.execute(status);
    result.fold(
      (failure) {
        _ordersState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (ordersData) {
        _ordersState = RequestState.Loaded;
        _orders = ordersData;
        notifyListeners();
      },
    );
  }
}

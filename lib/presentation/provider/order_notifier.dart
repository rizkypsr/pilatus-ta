import 'package:flutter/material.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/order.dart';
import 'package:pilatus/domain/entities/shipping.dart';
import 'package:pilatus/domain/usecases/checkout.dart';
import 'package:pilatus/domain/usecases/get_order.dart';
import 'package:pilatus/utils/firebase_dynamic_link_service.dart';
import 'package:pilatus/utils/url_launch.dart';

class OrderNotifier extends ChangeNotifier {
  final Checkout checkout;
  final GetOrder getOrder;

  OrderNotifier({required this.checkout, required this.getOrder});

  var _order = Orders();
  Orders get order => _order;

  String _message = '';
  String get message => _message;

  RequestState _orderState = RequestState.Empty;
  RequestState get orderState => _orderState;

  RequestState _checkoutState = RequestState.Empty;
  RequestState get checkoutState => _checkoutState;

  Future<void> fetchOrder(String id) async {
    _checkoutState = RequestState.Loading;
    notifyListeners();

    final result = await getOrder.execute(id);
    result.fold(
      (failure) {
        _orderState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (orderData) {
        _orderState = RequestState.Loaded;
        _order = orderData;
        notifyListeners();
      },
    );
  }

  Future<void> checkoutProduct(
      Shipping shipping, int cartId, BuildContext context) async {
    _checkoutState = RequestState.Loading;
    notifyListeners();

    final result = await checkout.execute(shipping, cartId);
    result.fold(
      (failure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (orderData) {
        FirebaseDynamicLinkService.createDynamicLink(orderData);
        _checkoutState = RequestState.Loaded;
        notifyListeners();
        UrlLaunch.launchURL(orderData.paymentUrl!);
      },
    );
  }
}

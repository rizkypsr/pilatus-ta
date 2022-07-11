import 'package:flutter/material.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/cart_item.dart';
import 'package:pilatus/domain/usecases/add_to_cart.dart';
import 'package:pilatus/domain/usecases/get_cart_items.dart';
import 'package:pilatus/domain/usecases/remove_cart_item.dart';

class CartNotifier extends ChangeNotifier {
  static const addToCartSuccessMessage =
      'Berhasil menambahkan produk ke keranjang';
  static const removeFromCartSuccessMessage =
      'Berhasil menghapus produk dari keranjang';

  final GetCartItems getCartItems;
  final AddToCart addToCart;
  final RemoveCartItem removeCartItem;

  var _cartItems = <CartItem>[];
  List<CartItem> get cartItems => _cartItems;

  RequestState _cartState = RequestState.Empty;
  RequestState get cartState => _cartState;

  RequestState _addCartState = RequestState.Empty;
  RequestState get addCartState => _addCartState;

  RequestState _removeCartState = RequestState.Empty;
  RequestState get removeCartState => _removeCartState;

  String _message = '';
  String get message => _message;

  String _addCartMessage = '';
  String get addCartMessage => _addCartMessage;

  String _removeCartMessage = '';
  String get removeCartMessage => _removeCartMessage;

  CartNotifier(
      {required this.getCartItems,
      required this.addToCart,
      required this.removeCartItem});

  Future<void> addProductToCart(int productId) async {
    _addCartState = RequestState.Loading;
    notifyListeners();

    final result = await addToCart.execute(productId);
    result.fold(
      (failure) {
        _addCartState = RequestState.Error;
        _addCartMessage = failure.message;
        notifyListeners();
      },
      (message) {
        _addCartState = RequestState.Loaded;
        _addCartMessage = message;
        notifyListeners();
      },
    );
  }

  Future<void> removeProductFromCart(int cartItemId) async {
    _removeCartState = RequestState.Loading;
    notifyListeners();

    final result = await removeCartItem.execute(cartItemId);
    result.fold(
      (failure) {
        _removeCartState = RequestState.Error;
        _removeCartMessage = failure.message;
        notifyListeners();
      },
      (message) {
        _removeCartState = RequestState.Loaded;
        _removeCartMessage = message;
        notifyListeners();

        fetchCartItems();
      },
    );
  }

  Future<void> fetchCartItems() async {
    _cartState = RequestState.Loading;
    notifyListeners();

    final result = await getCartItems.execute();
    result.fold(
      (failure) {
        _cartState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (cartItemsData) {
        if (cartItemsData.isEmpty) {
          _cartState = RequestState.Empty;
        } else {
          _cartState = RequestState.Loaded;
          _cartItems = cartItemsData;
        }
        notifyListeners();
      },
    );
  }
}

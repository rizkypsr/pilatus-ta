import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pilatus/data/datasources/auth_remote_data_source.dart';
import 'package:pilatus/data/datasources/cart_remote_data_source.dart';
import 'package:pilatus/data/datasources/category_remote_data_source.dart';
import 'package:pilatus/data/datasources/ongkir_remote_data_source.dart';
import 'package:pilatus/data/datasources/order_remote_data_source.dart';
import 'package:pilatus/data/datasources/product_remote_data_source.dart';
import 'package:pilatus/data/repositories/auth_repository_impl.dart';
import 'package:pilatus/data/repositories/cart_repository_impl.dart';
import 'package:pilatus/data/repositories/category_repository_impl.dart';
import 'package:pilatus/data/repositories/ongkir_repository_impl.dart';
import 'package:pilatus/data/repositories/order_repository_impl.dart';
import 'package:pilatus/data/repositories/product_repository_impl.dart';
import 'package:pilatus/domain/repositories/auth_repository.dart';
import 'package:pilatus/domain/repositories/cart_repository.dart';
import 'package:pilatus/domain/repositories/category_repository.dart';
import 'package:pilatus/domain/repositories/ongkir_repository.dart';
import 'package:pilatus/domain/repositories/order_repository.dart';
import 'package:pilatus/domain/repositories/product_repository.dart';
import 'package:pilatus/domain/usecases/add_to_cart.dart';
import 'package:pilatus/domain/usecases/checkout.dart';
import 'package:pilatus/domain/usecases/get_cart_items.dart';
import 'package:pilatus/domain/usecases/get_categories.dart';
import 'package:pilatus/domain/usecases/get_cities.dart';
import 'package:pilatus/domain/usecases/get_costs.dart';
import 'package:pilatus/domain/usecases/get_order_by_status.dart';
import 'package:pilatus/domain/usecases/get_order.dart';
import 'package:pilatus/domain/usecases/get_product_by_category.dart';
import 'package:pilatus/domain/usecases/get_products.dart';
import 'package:pilatus/domain/usecases/get_provinces.dart';
import 'package:pilatus/domain/usecases/login.dart';
import 'package:pilatus/domain/usecases/logout.dart';
import 'package:pilatus/domain/usecases/register.dart';
import 'package:pilatus/domain/usecases/remove_cart_item.dart';
import 'package:pilatus/presentation/provider/auth_notifier.dart';
import 'package:pilatus/presentation/provider/cart_notifier.dart';
import 'package:pilatus/presentation/provider/category_notifier.dart';
import 'package:pilatus/presentation/provider/ongkir_notifier.dart';
import 'package:pilatus/presentation/provider/order_list_notifier.dart';
import 'package:pilatus/presentation/provider/order_notifier.dart';
import 'package:pilatus/presentation/provider/product_by_category_notifier.dart';
import 'package:pilatus/presentation/provider/product_list_notifier.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => ProductListNotifier(getProducts: locator()));
  locator.registerFactory(() => CartNotifier(
      getCartItems: locator(),
      addToCart: locator(),
      removeCartItem: locator()));
  locator.registerFactory(() => OngkirNotifier(
      getProvinces: locator(), getCities: locator(), getCosts: locator()));
  locator.registerFactory(
      () => OrderNotifier(checkout: locator(), getOrder: locator()));
  locator.registerFactory(() => OrderListNotifier(getOrderByStatus: locator()));
  locator.registerFactory(() => CategoryNotifier(getCategories: locator()));
  locator.registerFactory(
      () => ProductByCategoryNotifier(getProductByCategory: locator()));
  locator.registerFactory(() => AuthNotifier(
      storage: locator(),
      login: locator(),
      register: locator(),
      logout: locator()));

  // use case
  locator.registerLazySingleton(() => GetProducts(locator()));
  locator.registerLazySingleton(() => GetCartItems(locator()));
  locator.registerLazySingleton(() => AddToCart(locator()));
  locator.registerLazySingleton(() => RemoveCartItem(locator()));
  locator.registerLazySingleton(() => GetProvinces(locator()));
  locator.registerLazySingleton(() => GetCities(locator()));
  locator.registerLazySingleton(() => GetCosts(locator()));
  locator.registerLazySingleton(() => Checkout(locator()));
  locator.registerLazySingleton(() => GetOrder(locator()));
  locator.registerLazySingleton(() => GetOrderByStatus(locator()));
  locator.registerLazySingleton(() => GetCategories(locator()));
  locator.registerLazySingleton(() => GetProductByCategory(locator()));
  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => Register(locator()));
  locator.registerLazySingleton(() => Logout(locator()));

  // repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<OngkirRepository>(
    () => OngkirRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<OrderRepository>(
    () => OrderRepositoyImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: locator(), storage: locator()));
  locator.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(client: locator(), storage: locator()));
  locator.registerLazySingleton<OngkirRemoteDataSource>(
      () => OngkirRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(client: locator(), storage: locator()));
  locator.registerLazySingleton<CategoryRemoteDataSource>(() =>
      CategoryRemoteDataSourceImpl(client: locator(), storage: locator()));
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: locator(), storage: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => const FlutterSecureStorage());
}

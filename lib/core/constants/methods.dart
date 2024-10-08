import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickalert/quickalert.dart';
import 'package:simple_ecommerce/core/constants/models/user.dart';
import 'package:simple_ecommerce/core/constants/values.dart';
import 'package:simple_ecommerce/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:simple_ecommerce/features/auth/data/repositories/auth_repositoriy.dart';
import 'package:simple_ecommerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:simple_ecommerce/features/cart/data/data_source/cart_local_data_source.dart';
import 'package:simple_ecommerce/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:simple_ecommerce/features/cart/data/models/cart.dart';
import 'package:simple_ecommerce/features/cart/data/repositories/cart_repo_impl.dart';
import 'package:simple_ecommerce/features/order_history/data/data_source/order_history_remote_data_source.dart';
import 'package:simple_ecommerce/features/order_history/data/repositories/order_history_repo_impl.dart';
import 'package:simple_ecommerce/features/order_history/domain/repositories/order_history_repo.dart';
import 'package:simple_ecommerce/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:simple_ecommerce/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:simple_ecommerce/features/profile/domain/repositories/profile_repo.dart';
import 'package:simple_ecommerce/features/shop/data/data_source/shop_local_data_source.dart';
import 'package:simple_ecommerce/features/shop/data/data_source/shop_remote_data_source.dart';
import 'package:simple_ecommerce/features/shop/data/models/category.dart';
import 'package:simple_ecommerce/features/shop/data/models/product.dart';
import 'package:simple_ecommerce/features/shop/data/repositories/shop_repo_impl.dart';
import 'package:simple_ecommerce/features/shop/domain/repositories/shop_repo.dart';

Future<void> initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Product>(ProductAdapter());
  Hive.registerAdapter<Category>(CategoryAdapter());
  Hive.registerAdapter<Cart>(CartAdapter());
  await Hive.openBox<Product>(kShopBox);
  await Hive.openBox<Cart>(kCartBox);
}

void initializeLocators() {
  final dio = Dio();
  getit.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getit.registerLazySingleton<AuthRepository>(
    () => AuthRepositoriyImpl(
      remoteDataSource: AuthRemoteDataSourceImpl(dio: dio),
    ),
  );
  getit.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(
      remoteDataSource: ShopRemoteDataSourceImpl(dio: dio),
      localDataSource: ShopLocalDataSourceImpl(),
    ),
  );
  getit.registerLazySingleton<CartRepositoryImpl>(
    () => CartRepositoryImpl(
        cartLocalDataSource: CartLocalDataSourceImpl(),
        cartRemoteDataSource: CartRemoteDataSourceImpl(dio: dio)),
  );
  getit.registerLazySingleton<OrderHistoryRepository>(
    () => OrderHistoryRepositoryImpl(
      remoteDataSource: OrderHistoryRemoteDataSourceImpl(dio: dio),
    ),
  );
  getit.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
        profileRemoteDataSource: ProfileRemoteDataSourceImpl(dio: dio)),
  );
}

void saveToProducts(List<Product> products, String boxName) async {
  var box = Hive.box<Product>(boxName);
  box.addAll(products);
}

Future<void> showLoadingQuickAlert(
    BuildContext context, String? title, String? body) async {
  await QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: title ?? 'Loading',
      text: body ?? 'Please wait while we are processing your request');
}

Future<void> showErrorQuickAlert(
    BuildContext context, String? title, String? body) async {
  await QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: title ?? 'Error',
      text: body ?? 'An error has occured');
}

bool checkName(String text) {
  return RegExp(r"^[A-Za-z][A-Za-z'-]{0,24}$").hasMatch(text);
}

Future<void> cacheUser(User user) async {
  final secureStorage = getit.get<FlutterSecureStorage>();
  await secureStorage.write(key: 'token', value: user.token!);
  await secureStorage.write(key: kEmailPref, value: user.email);
  await secureStorage.write(key: kFirstNamePref, value: user.firstName);
  await secureStorage.write(key: kLastNamePref, value: user.lastName);
  await secureStorage.write(key: kId, value: user.id);
}

Future<void> clearCache() async {
  await getit.get<FlutterSecureStorage>().deleteAll();
}

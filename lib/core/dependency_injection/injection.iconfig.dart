// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:bakery/core/dependency_injection/third_party_module.dart';
import 'package:dio/dio.dart';
import 'package:bakery/data_source/food/food_data_source.dart';
import 'package:bakery/data_source/gift_card/gift_card_data_source.dart';
import 'package:bakery/modules/data/food_repo.dart';
import 'package:bakery/modules/data/gift_card_repo.dart';
import 'package:bakery/data_source/order/order_data_source.dart';
import 'package:bakery/data_source/profile/profile_data_source.dart';
import 'package:bakery/core/services/push_notification_service.dart';
import 'package:bakery/data_source/review/review_data_source.dart';
import 'package:bakery/data_source/auth/auth_data_source.dart';
import 'package:bakery/data_source/category/category_data_source.dart';
import 'package:bakery/data_source/delivery/delivery_data_source.dart';
import 'package:bakery/modules/data/auth_repo.dart';
import 'package:bakery/modules/data/category_repo.dart';
import 'package:bakery/modules/data/delivery_repo.dart';
import 'package:bakery/modules/data/order_repo.dart';
import 'package:bakery/modules/data/profile_repo.dart';
import 'package:bakery/modules/data/review_repo.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyModules = _$ThirdPartyModules();
  g.registerLazySingleton<Dio>(() => thirdPartyModules.dio);
  g.registerFactory<FoodDataSource>(() => FoodDataSource(g<Dio>()));
  g.registerFactory<GiftCardDataSource>(() => GiftCardDataSource(g<Dio>()));
  g.registerFactory<IFoodRepo>(() => FoodRepo(g<FoodDataSource>()));
  g.registerFactory<IGiftCardRepo>(() => GiftCardRepo(g<GiftCardDataSource>()));
  g.registerFactory<OrderDataSource>(() => OrderDataSource(g<Dio>()));
  g.registerFactory<ProfileDataSource>(() => ProfileDataSource(g<Dio>()));
  g.registerLazySingleton<PushNotificationService>(
      () => thirdPartyModules.pushNotificationService);
  g.registerFactory<ReviewDataSource>(() => ReviewDataSource(g<Dio>()));
  g.registerFactory<AuthDataSource>(() => AuthDataSource(g<Dio>()));
  g.registerFactory<CategoryDataSource>(() => CategoryDataSource(g<Dio>()));
  g.registerFactory<DeliveryDataSource>(() => DeliveryDataSource(g<Dio>()));
  g.registerFactory<IAuthRepo>(() => AuthRepo(g<AuthDataSource>()));
  g.registerFactory<ICategoryRepo>(() => CategoryRepo(g<CategoryDataSource>()));
  g.registerFactory<IDeliveryRepo>(() => DeliveryRepo(g<DeliveryDataSource>()));
  g.registerFactory<IOrderRepo>(() => OrderRepo(g<OrderDataSource>()));
  g.registerFactory<IProfileRepo>(() => ProfileRepo(g<ProfileDataSource>()));
  g.registerFactory<IReviewRepo>(
      () => ReviewRepo(reviewDataSource: g<ReviewDataSource>()));
}

class _$ThirdPartyModules extends ThirdPartyModules {
  @override
  PushNotificationService get pushNotificationService =>
      PushNotificationService();
}

import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  // Loading other dependecies. Load the apiClient first.

  //  api client.
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos.
  Get.lazyPut(() => PopularProdutRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProdutRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //Controllers.
  Get.lazyPut(() => PopularProductController(popularProdutRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProdutRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}

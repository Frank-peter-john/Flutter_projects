import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  // Load the dependecies here before running the app.
  WidgetsFlutterBinding
      .ensureInitialized(); /* this line ensures the dependecies are loaded.*/
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData(); /* deals with local storage*/
    // This nested get builders helps to store the controllers in memory after the screen is drawn.
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              // home: const SplashScreen(),
              initialRoute: RouteHelper.getSpalshPage(),
              getPages: RouteHelper.routes,
            );
          },
        );
      },
    );
  }
}

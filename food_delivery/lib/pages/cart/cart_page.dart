import "package:flutter/material.dart";
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Navigation bar.
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backGroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getHomepage());
                    },
                    child: AppIcon(
                      icon: Icons.home,
                      iconColor: Colors.white,
                      backGroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  );
                }),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backGroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height25 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              // color: Colors.lightBlue,
              child: GetBuilder<CartController>(
                builder: (cartController) {
                  var _cartList = cartController.getItems;
                  return ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (_, index) {
                        return Container(
                          height: Dimensions.height20 * 5,
                          width: double.maxFinite,
                          child: Row(children: [
                            // IMAGE CONTAINER
                            GestureDetector(
                              onTap: () {
                                // FINDING INDEX OF A POPULAR ITEM.
                                var popularIndex =
                                    Get.find<PopularProductController>()
                                        .PopularProdutList
                                        .indexOf(_cartList[index].product!);
                                // RETURN TO THE POPULAR PAGE OF THIS PRODUCT.
                                if (popularIndex >= 0) {
                                  Get.toNamed(RouteHelper.getPopularFood(
                                      popularIndex, "cartpage"));
                                } else {
                                  //FINDING INDEX OF A RECOMMENDED ITEM.
                                  var recommendedIndex =
                                      Get.find<RecommendedProductController>()
                                          .recommendedProdutList
                                          .indexOf(_cartList[index].product!);
                                  // RETURN TO THE RECOMMENDED PAGE OF THIS PRODUCT.
                                  Get.toNamed(RouteHelper.getRecommendedFood(
                                      recommendedIndex, "cartpage"));
                                }
                              },
                              child: Container(
                                width: Dimensions.width20 * 5,
                                height: Dimensions.height20 * 5,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        cartController.getItems[index].img!),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.width10),
                            Expanded(
                              child: Container(
                                height: Dimensions.height20 * 5,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                        // display item name.
                                        text: cartController
                                            .getItems[index].name!,
                                        color: Colors.black54,
                                      ),
                                      SmallText(text: "Spice"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            // Displaying the price
                                            text:
                                                "\$${cartController.getItems[index].price}",
                                            color: Colors.redAccent,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: Dimensions.height10,
                                              bottom: Dimensions.height10,
                                              left: Dimensions.width10,
                                              right: Dimensions.width10,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  Dimensions.radius20,
                                                ),
                                                color: Colors.white),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  // Decrease item when the remove icon is tapped.
                                                  onTap: () {
                                                    cartController.addItem(
                                                        _cartList[index]
                                                            .product!,
                                                        -1);
                                                  },
                                                  child: const Icon(
                                                      Icons.remove,
                                                      color:
                                                          AppColors.signColor),
                                                ),
                                                SizedBox(
                                                    width: Dimensions.width10),
                                                BigText(
                                                  text: _cartList[index]
                                                      .quantity
                                                      .toString(),

                                                  // .toString(),
                                                  size: Dimensions.font24,
                                                ),
                                                SizedBox(
                                                    width: Dimensions.width10),
                                                GestureDetector(
                                                  onTap: () {
                                                    // increase an item when the add icon is tapped.
                                                    cartController.addItem(
                                                        _cartList[index]
                                                            .product!,
                                                        1);
                                                  },
                                                  child: const Icon(Icons.add,
                                                      color:
                                                          AppColors.signColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                              ),
                            )
                          ]),
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: Dimensions.height120,
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                )),
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height10,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius20,
                      ),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(width: Dimensions.width10),
                      BigText(
                        text: "\$ ${cartController.totalAmount}",
                        size: Dimensions.font24,
                        color: Colors.redAccent,
                      ),
                      SizedBox(width: Dimensions.width10),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // popularProduct.addItem(product);
                      cartController.addToHistory();
                    },
                    child: BigText(
                      text: "Checkout",
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

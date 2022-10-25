import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail(this.pageId, {super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProdutList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Top section with image and icons.
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == "cartpage") {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getHomepage());
                    }
                  },
                  child: const AppIcon(icon: Icons.clear),
                ),
                // const AppIcon(icon: Icons.shopping_cart_outlined),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (controller.totalItems >= 1) {
                              Get.toNamed(RouteHelper.getCartPage());
                            }
                          },
                          child: const AppIcon(
                              icon: Icons.shopping_cart_outlined)),
                      // displaying total items on top of the cart icon.
                      controller.totalItems >= 1
                          ? const Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backGroundColor: AppColors.mainColor,
                              ),
                            )
                          : Container(),
                      controller.totalItems >= 1
                          ? Positioned(
                              right: 3,
                              top: 3,
                              child: BigText(
                                text: controller.totalItems.toString(),
                                color: Colors.white,
                                size: 12,
                              ),
                            )
                          : Container(),
                    ],
                  );
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  top: Dimensions.height10 / 2,
                  bottom: Dimensions.height10,
                ),
                child: Center(
                  child: BigText(
                    size: Dimensions.font26,
                    text: product.name,
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimensions.expandedHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Middle section containing descrption.
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.radius20,
                  ),
                  child: ExpandableText(text: product.description!),
                ),
              ],
            ),
          ),
        ],
      ),
      // Bottom section
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: AppColors.buttonBackgroundColor,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: Dimensions.width20 * 2.5,
                    right: Dimensions.width20 * 2.5,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: const AppIcon(
                          icon: Icons.remove,
                          backGroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                        ),
                      ),
                      BigText(
                        text:
                            "\$ ${product.price!}  X  ${controller.incartItems}",
                        color: AppColors.mainBlackColor,
                        size: Dimensions.font26,
                      ),
                      GestureDetector(
                        // This method increases the quantity when the add icon is tapped.
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          icon: Icons.add,
                          backGroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          child: const Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          )),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(product);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height10,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor,
                          ),
                          child: BigText(
                            text: "\$ ${product.price} || Add to cart",
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

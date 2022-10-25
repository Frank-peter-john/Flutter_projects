import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_colum.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../models/popular_product.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  // CREATING THE SCALING EFFECT.
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final _height = Dimensions.pageViewContainer;

//  Create values for the page value.
  @override
  void initState() {
    super.initState();
    pageController.addListener(
      () {
        setState(() {
          _currPageValue = pageController.page!;
        });
      },
    );
  }

  // Dispose the page value after use(remove it from the memory).
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SLIDER SECTION.
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoaded
                ? Container(
                    height: Dimensions.pageView,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.PopularProdutList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.PopularProdutList[position]);
                      },
                    ),
                  )
                : const CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
        // DOTS.
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return DotsIndicator(
              dotsCount: popularProducts.PopularProdutList.isEmpty
                  ? 1
                  : popularProducts.PopularProdutList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            );
          },
        ),
        //POPULAR SECTION
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food Pairing"),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        // List of foods and images.
        // Recommended Food.
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProduct) {
            return recommendedProduct.isLoaded
                ? GestureDetector(
                    // Route to recommended food page.

                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          recommendedProduct.recommendedProdutList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Get.toNamed(
                              // Route to reccomended food page.
                              RouteHelper.getRecommendedFood(index, "home")),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                                bottom: Dimensions.width20),
                            child: Row(
                              children: [
                                //image sub-section.
                                Container(
                                  width: Dimensions.listViewImgSize,
                                  height: Dimensions.height120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white54,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      //Get images dynamicallly from server.
                                      image: NetworkImage(
                                        AppConstants.BASE_URL +
                                            AppConstants.UPLOAD_URL +
                                            recommendedProduct
                                                .recommendedProdutList[index]
                                                .img!,
                                      ),
                                    ),
                                  ),
                                ),
                                // Text sub-section
                                Expanded(
                                  child: Container(
                                    height: Dimensions.listViewTextContSize,
                                    width: Dimensions.listViewImgSize,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              Dimensions.radius20),
                                          bottomRight: Radius.circular(
                                              Dimensions.radius20)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Dimensions.width10,
                                          right: Dimensions.width10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BigText(
                                              text: recommendedProduct
                                                  .recommendedProdutList[index]
                                                  .name!),
                                          SizedBox(height: Dimensions.height10),
                                          SmallText(
                                              text:
                                                  "With chinese characteristics"),
                                          SizedBox(height: Dimensions.height10),
                                          Row(
                                            children: [
                                              const IconTextwidget(
                                                  icon: Icons.circle_sharp,
                                                  text: 'Normal',
                                                  iconColor:
                                                      AppColors.iconColor1),
                                              SizedBox(
                                                  width: Dimensions.width10),
                                              const IconTextwidget(
                                                  icon: Icons.location_on,
                                                  text: '1.7km',
                                                  iconColor:
                                                      AppColors.mainColor),
                                              const SizedBox(width: 10),
                                              const IconTextwidget(
                                                  icon:
                                                      Icons.access_time_rounded,
                                                  text: '32min',
                                                  iconColor:
                                                      AppColors.iconColor2)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        )
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProdut) {
    // The actual scaling happens here.
    Matrix4 matrix =
        Matrix4.identity(); /*matrix API from dart, returns coordinates x,y& z*/
    if (index == _currPageValue.floor()) {
      var currentScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currentPosition = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentPosition, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currentPosition = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentPosition, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currentScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currentPosition = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentPosition, 0);
    } else {
      var currentScale = 0.8;
      var currentPosition = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentPosition, 0);
    }

    return Transform(
      transform: matrix,
      // Wrap the stack widget inside the transform widget to see the scaling effect.
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              // This opens the popular food page when tapped.
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven
                    ? const Color(0xFf69c5df)
                    : const Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      popularProdut.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: Offset(0, 5),
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: AppColumn(text: popularProdut.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

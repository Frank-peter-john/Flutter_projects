import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/popular_product.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProdutRepo popularProdutRepo;

  PopularProductController({required this.popularProdutRepo});

  List<dynamic> _popularProductList = [];
  // ignore: non_constant_identifier_names
  List<dynamic> get PopularProdutList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int _inCartItems = 0;
  int get quantity => _quantity;
  int get incartItems => _inCartItems + _quantity;
  late CartController _cart;

// This method calls the PopularProductRepo method from the repostory.
  Future<void> getPopularProductList() async {
    Response response = await popularProdutRepo.getPopularProductList();

    if (response.statusCode == 200) {
      // First initialize the list to null, to avoid data repitition.
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print("did not get popular products");
    }
  }

//  This method increases or decreases the product quantity.
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      print("Number of items is $_quantity");
    } else {
      _quantity = checkQuantity(_quantity - 1);
      print("Number of items is $_quantity");
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Item count:",
        "You can't reduce more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Item count:",
        "You can't add more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    print("Item exists $exist");

    if (exist) {
      _inCartItems = _cart.getQuantity(product);
      print("The id is ${product.id} quantity in the cart is $_inCartItems");
    }
  }

  void addItem(ProductModel product) {
    // Checking if quantity is not zero before adding to cart.

    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      // print("The id is ${value.id} and the quantity is ${value.quantity}");
    });

    // Updating the UI after changes in the cart.
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}

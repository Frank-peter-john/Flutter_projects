import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/popular_product.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems =
      []; /* For local storage and sharedpreferences*/

  // This method adds items to the cart when called.
  void addItem(ProductModel product, int quantity) {
    // Update the items list when the quantity of the same product is added.

    var totalQuantity =
        0; /*This is the totalquantity of a single product in the list*/
    if (_items.containsKey(product.id!)) {
      _items.update(
        product.id!,
        (value) {
          totalQuantity = value.quantity! + quantity;
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: value.quantity! + quantity,
            time: DateTime.now().toString(),
            isExist: true,
            product: product,
          );
        },
      );
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        // Checking if the item does not exist in the list then we add it.
        _items.putIfAbsent(
          product.id!,
          () {
            return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              time: DateTime.now().toString(),
              isExist: true,
              product: product,
            );
          },
        );
      } else {
        Get.snackbar(
          "No Item added:",
          "Add atleast one item to the cart",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    // Adding and updating the cart List for local storage.
    cartRepo.addToCartList(getItems);
    update();
  }

// This method compares the id in the Product model to that in the Cart model.
  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

// This method gets the quantity of a product that has been added to cart.
// The quantity will be displayed when the customer comes back to this product next time.
  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

// This method gets the total number of items added to the cart.
  int get totalItems {
    var totalQuantity =
        0; /*This is the totalquantity of all products in the list */
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });

    return totalQuantity;
  }

// This getter method gets the list of all cart models from _items.
  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

// This method returns the total price of all items.
  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });

    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print("Length of cart items is ${storageItems.length}");
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

// Calling the method in the repo for adding items in the history.
  void addToHistory() {
    cartRepo.adddToHistoryList();
  }
}

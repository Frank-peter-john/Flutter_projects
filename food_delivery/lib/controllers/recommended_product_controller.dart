import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/models/popular_product.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProdutRepo recommendedProdutRepo;

  RecommendedProductController({required this.recommendedProdutRepo});

  List<dynamic> _recommendedProductList = [];
  // ignore: non_constant_identifier_names
  List<dynamic> get recommendedProdutList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

// This method calls the PopularProductRepo method from the repostory.
  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProdutRepo.getRecommendedProductList();

    if (response.statusCode == 200) {
      // First initialize the list to null, to avoid data repitition.
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print("Did not get recommended products");
    }
  }
}

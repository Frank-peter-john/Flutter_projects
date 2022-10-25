import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecommendedProdutRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProdutRepo({required this.apiClient});

//  This method calls the apiclient get method.
  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}

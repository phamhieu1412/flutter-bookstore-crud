import 'package:bookstore_crud/utils/constants.dart';
import 'package:get/get.dart';
import 'package:bookstore_crud/db/api/api_client.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(Constants.RECOMMEND_PRODUCT_URL);
  }
}

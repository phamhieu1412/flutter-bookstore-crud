import 'package:bookstore_crud/utils/constants.dart';
import 'package:get/get.dart';
import 'package:bookstore_crud/db/api/api_client.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(Constants.POPULAR_PRODUCT_URL);
    // return await apiClient.getData("https:/www.dbestech.com/api/product/list");
  }
}

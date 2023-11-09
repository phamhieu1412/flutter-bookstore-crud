import 'package:bookstore_crud/utils/constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 45);
    token = Constants.TOKEN;
    _mainHeaders = {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String url) async {
    try {
      Response res = await get(url);
      return res;
    } catch (e) {
      return Response(statusCode: 999, statusText: e.toString());
    }
  }
}

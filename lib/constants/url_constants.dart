import 'package:klontong_app/utils/utils.dart';

class UrlConstant {
  final String tokenApi;
  late final String baseUrl;
  late final String product;

  UrlConstant._(this.tokenApi) {
    baseUrl = "https://crudcrud.com/api/$tokenApi";
    product = "$baseUrl/product";
  }

  static Future<UrlConstant> create() async {
    String token = await RemoteConfig.fetchTokenApi();
    return UrlConstant._(token);
  }
}

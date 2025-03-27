import 'package:klontong_app/utils/utils.dart';
class UrlConstant {
  final String tokenApi;
  late final String baseUrl;
  late final String product;

  // Private constructor
  UrlConstant._(this.tokenApi) {
    baseUrl = "https://crudcrud.com/api/$tokenApi";
    product = "$baseUrl/product";
  }

  // Factory method to initialize with async token
  static Future<UrlConstant> create() async {
    String token = await RemoteConfig.fetchTokenApi();
    return UrlConstant._(token);
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:u20201b973_eb/database/database.dart';


class HttpHelper {
  final baseUrl = "https://dummyjson.com";
  final productsUrl = "/products";

  Future<List<Product>> listProducts() async {
    final response = await http.get(Uri.parse("$baseUrl$productsUrl"));
    return response.statusCode == HttpStatus.ok ? _responseMap(response, Product.fromJson) : List.empty();
  }

  List<Ty> _responseMap<Ty>(http.Response response, Ty Function(Map<String, dynamic>) converter) =>
      (jsonDecode(response.body)["products"] as Iterable)
          .map((item) => converter(item)).toList();
}
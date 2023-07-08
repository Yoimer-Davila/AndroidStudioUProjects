import 'package:http/http.dart' as http;
import 'package:week_fourteen_networking_and_persistence/models/movie.dart';
import 'dart:convert';
import 'dart:io';



class HttpHelper {
  final urlBase = "https://api.themoviedb.org/3/movie";
  final urlUpcoming = "/upcoming";
  final queryKey = "?api_key=3cae426b920b29ed2fb1c0749f258325";
  static const urlBaseImage = "https://image.tmdb.org/t/p/w500";
  final urlPage = "&page=";

  Future<List<Movie>> upcoming(String page) async {
    final response = await http.get(Uri.parse("$urlBase$urlUpcoming$queryKey$urlPage$page"));
    return response.statusCode == HttpStatus.ok ? _responseMap(response, Movie.fromJson) : List.empty();
  }

  List<Ty> _responseMap<Ty>(http.Response response, Ty Function(Map<String, dynamic>) converter) =>
      (jsonDecode(response.body)["results"] as Iterable)
          .map((item) => converter(item)).toList();
}
import 'package:flutter/material.dart';
import 'package:week_fourteen_networking_and_persistence/models/movie.dart';
import 'package:week_fourteen_networking_and_persistence/utils/http_helper.dart';
import 'package:week_fourteen_networking_and_persistence/ui/movie_row.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<Movie> movies = [];
  final HttpHelper helper = HttpHelper();
  int page = 1;
  bool loading = true;
  int moviesCount = 0;
  late ScrollController _scrollController;

  Future init() async {
    loadMore();
    initController();
  }

  void loadMore() {
    helper.upcoming(page.toString()).then((value) {
      movies += value;
      setState(() {
        movies = movies;
        moviesCount = movies.length;
        page++;
      });
      if(movies.length % 20 > 0){
        loading = false;
      }
    });
  }

  void initController() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if((_scrollController.position.pixels == _scrollController.position.maxScrollExtent) && loading) {
        loadMore();
      }
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("My movies"),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        controller: _scrollController,
        itemBuilder: (context, index) => MovieRow(movie: movies[index]),
      ),
    );
  }
}




import 'package:flutter/material.dart';

import 'package:week_fourteen_networking_and_persistence/models/movie.dart';
import 'package:week_fourteen_networking_and_persistence/utils/db_helper.dart';
import 'package:week_fourteen_networking_and_persistence/utils/http_helper.dart';

class MovieDetail extends StatefulWidget {
  final Movie movie;
  const MovieDetail(this.movie, {super.key});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  DbHelper helper = DbHelper();
  String imagePath = "";
  bool isFavorite = false;

  void initMovie() {
    imagePath = "${HttpHelper.urlBaseImage}/${widget.movie.posterPath}";
  }

  @override
  void initState() {
    isFavorite = widget.movie.isFavorite;
    super.initState();
    initMovie();
  }

  @override
  void setState(VoidCallback fn) {
    if(mounted) {
      super.setState(fn);
    }
  }


  void saveOrDeleteMovie() {
    isFavorite ? helper.deleteMovie(widget.movie) : helper.insertMovie(widget.movie);
    setState(() {
      isFavorite = !isFavorite;
      widget.movie.isFavorite = isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Hero(
                  tag: "poster_${widget.movie.id}",
                  child: Image.network(
                      imagePath,
                    height: height / 1.5,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                color: isFavorite ? Colors.red : Colors.grey,
                onPressed: () => helper.executeIfOrOpen(consumer: saveOrDeleteMovie),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                child: Text(widget.movie.overview),
              )
            ],
          ),
        ),
      ),
    );
  }
}

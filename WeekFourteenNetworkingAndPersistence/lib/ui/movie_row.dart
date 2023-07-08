import 'package:flutter/material.dart';
import 'package:week_fourteen_networking_and_persistence/models/movie.dart';
import 'package:week_fourteen_networking_and_persistence/utils/db_helper.dart';
import 'package:week_fourteen_networking_and_persistence/utils/http_helper.dart';
import 'package:week_fourteen_networking_and_persistence/utils/navigation.dart' as nav;

import 'movie_details.dart';
class MovieRow extends StatefulWidget {
  final Movie movie;
  const MovieRow({super.key, required this.movie});
  @override
  State<MovieRow> createState() => _MovieRowState();
}

class _MovieRowState extends State<MovieRow> {
  bool favorite = false;
  final DbHelper helper = DbHelper();
  String imagePath = "";

  void helperExecute(Function consumer) => helper.executeIfOrOpen(consumer: consumer);

  void initMovie() {
    imagePath = "${HttpHelper.urlBaseImage}/${widget.movie.posterPath}";
  }


  @override
  void initState() {
    helper.changeDatabaseName("movies");
    initMovie();
    super.initState();
  }

  Future isFavorite() async {
    favorite = await helper.isFavoriteMovie(widget.movie);
    setState(() {
      widget.movie.isFavorite = favorite;
    });
  }

  void saveOrDeleteMovie() {
    favorite ? helper.deleteMovie(widget.movie) : helper.insertMovie(widget.movie);
    setState(() {
      favorite = !favorite;
      widget.movie.isFavorite = favorite;
    });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    helper.executeIfOrOpen(consumer: isFavorite);
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: Hero(
          tag: "poster_${widget.movie.id}",
          child: Image.network(imagePath),
        ),
        title: Text(widget.movie.title),
        subtitle: Text("${widget.movie.releaseDate} - ${widget.movie.popularity}"),
        trailing: IconButton(
          icon: const Icon(Icons.favorite),
          color: widget.movie.isFavorite ? Colors.red : Colors.grey,
          onPressed: () => helper.executeIfOrOpen(consumer: saveOrDeleteMovie),
        ),
        onTap: () => nav.to(context, MovieDetail(widget.movie)),
      ),
    );
  }
}
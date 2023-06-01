import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RandomWords(),
    );
  }
}

class FavoriteWords extends StatelessWidget {
  final Set<WordPair> words;
  final TextStyle textStyle;

  const FavoriteWords({Key? key, required this.words, required this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites words"),
      ),
      body: ListView(
        children: ListTile.divideTiles(
            tiles: words.map((pair) => ListTile(
              title: Text(
                pair.asPascalCase,
                style: textStyle,
              ),
            )),
            context: context
        ).toList(),
      ),
    );
  }
}


class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> suggestions = [];
  final TextStyle biggerFont = const TextStyle(fontSize: 18);
  final saved = <WordPair>{};

  Widget buildRow(WordPair pair) {
    final alreadySaved = saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            alreadySaved ? saved.remove(pair) : saved.add(pair);
          });
        },
        icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border),
        color: alreadySaved ? Colors.red : null,
      ),
    );
  }

  Widget buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(15.0),
      itemBuilder: (context, i) {
        if(i.isOdd) {
          return const Divider(
            color: Colors.black38,
            height: 10.0,
          );
        }
        final index = i ~/ 2;
        if(index >= suggestions.length) {
          suggestions.addAll(generateWordPairs().take(10));
        }
        return buildRow(suggestions[index]);
      },
    );
  }

  void toSaved() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FavoriteWords(
          words: saved,
          textStyle: biggerFont,
        ))
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Words"),
        actions: <Widget>[
          IconButton(
            onPressed: toSaved,
            icon: const Icon(Icons.list),
          )
        ],
      ),
      body: buildSuggestions(),
    );
  }

}

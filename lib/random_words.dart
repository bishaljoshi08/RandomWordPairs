import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, item){
        if(item.isOdd) return Divider();

        final index = item ~/ 2;
        if (index >= _randomWordPairs.length){
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      }
    );
  }

  Widget _buildRow(WordPair word) {
    final savedAlready = _savedWordPairs.contains(word);
    return ListTile(
      title: Text(word.asPascalCase, 
        style: TextStyle(fontSize: 18)),
      trailing: Icon(savedAlready ? Icons.favorite : Icons.favorite_border, 
        color: savedAlready ? Colors.red[900] : null),
      onTap: () {
        setState(() {
          if (savedAlready) {
            _savedWordPairs.remove(word);
          } else {
            _savedWordPairs.add(word);
          }
          
        });
      }
    );
  }

  void _pushSaved() { 
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair word) {
            return ListTile(
              title: Text(word.asPascalCase, style: TextStyle(fontSize:16))
            );
          });

          final List<Widget> divided = ListTile.divideTiles(
            tiles: tiles, 
            context: context
          ).toList();

          return Scaffold(
            appBar: AppBar(title: Text('Malai man pareko')),
            body: ListView(children: divided)
          );
        }
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPairs Chapakkai'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
        ),
      body: _buildList()
    );
  }
}
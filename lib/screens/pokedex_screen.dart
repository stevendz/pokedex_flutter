import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pokedex/widgets/pokedex_entry_grid.dart';
import 'package:pokedex/widgets/pokedex_entry_list.dart';

class PokeDexScreen extends StatefulWidget {
  @override
  _PokeDexScreenState createState() => _PokeDexScreenState();
}

Future<List> fetchPokemons() async {
  var result = await http.get('https://pokeapi.co/api/v2/pokemon/?limit=151');
  return json.decode(result.body)['results'];
}

class _PokeDexScreenState extends State<PokeDexScreen> {
  bool displayGrid = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPokemons(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Material(child: Center(child: CircularProgressIndicator()));
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Pokedex',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  displayGrid ? Icons.view_list : Icons.view_module,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(
                    () {
                      displayGrid = !displayGrid;
                    },
                  );
                },
              ),
            ],
          ),
          body: displayGrid
              ? GridView.builder(
                  padding: EdgeInsets.all(15),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.35,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PokeDexEntryGrid(
                      pokemon: snapshot.data[index]['url'],
                    );
                  },
                )
              : ListView.builder(
                  padding: EdgeInsets.all(15),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: PokeDexEntryList(
                        pokemon: snapshot.data[index]['url'],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/services/capitalize_string.dart';
import 'package:pokedex/services/type_color.dart';

class PokeDexEntryList extends StatefulWidget {
  final String pokemon;
  const PokeDexEntryList({
    Key key,
    this.pokemon,
  }) : super(key: key);

  @override
  _PokeDexEntryListState createState() => _PokeDexEntryListState();
}

class _PokeDexEntryListState extends State<PokeDexEntryList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPokemon(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Material(child: Center(child: CircularProgressIndicator()));
        String image =
            snapshot.data['sprites']['other']['dream_world']['front_default'];
        String name = snapshot.data['species']['name'];
        List types = snapshot.data['types'];
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: getTypeColor(types[0]['type']['name']),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    capitalize(name),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 2, color: Colors.blueGrey)],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(top: 5),
                      itemCount: types.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            margin: EdgeInsets.only(left: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            child: Text(
                              capitalize(
                                types[index]['type']['name'],
                              ),
                              style: TextStyle(color: Colors.white, shadows: [
                                Shadow(blurRadius: 2, color: Colors.blueGrey)
                              ]),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(5),
              child: SvgPicture.network(
                image,
              ),
            ),
          ],
        );
      },
    );
  }

  Future fetchPokemon() async {
    var result = await http.get(widget.pokemon);
    return json.decode(result.body);
  }
}

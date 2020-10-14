import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/screens/pokemon_details_screen.dart';
import 'package:pokedex/services/capitalize_string.dart';
import 'package:pokedex/services/format_pokedex_id.dart';
import 'package:pokedex/services/pokeapi_co.dart';
import 'package:pokedex/services/type_color.dart';
import 'package:pokedex/widgets/pokemon_types.dart';

class PokeDexEntryGrid extends StatefulWidget {
  final String pokemon;
  const PokeDexEntryGrid({
    Key key,
    this.pokemon,
  }) : super(key: key);

  @override
  _PokeDexEntryGridState createState() => _PokeDexEntryGridState();
}

class _PokeDexEntryGridState extends State<PokeDexEntryGrid> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPokemon(widget.pokemon),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Material(child: Center(child: CircularProgressIndicator()));
        Map pokemon = snapshot.data;
        String image =
            pokemon['sprites']['other']['dream_world']['front_default'];
        String name = pokemon['species']['name'];
        List<String> types = [];
        pokemon['types'].forEach((type) => types.add(type['type']['name']));
        String primaryType = types[0];
        String id = pokemon['id'].toString();
        String pokedexId = formatPokedexId(id);
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokemonDetailsScreen(
                id: pokedexId,
                image: image,
                name: name,
                primaryType: primaryType,
                types: types,
              ),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: getTypeColor(primaryType),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalize(name),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [
                          Shadow(blurRadius: 2, color: Colors.blueGrey)
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    PokemonTypes(types: types, displayRow: false),
                  ],
                ),
              ),
              Container(
                width: 85,
                height: 85,
                padding: EdgeInsets.all(5),
                child: Hero(
                  tag: '$name image',
                  child: SvgPicture.network(
                    image,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

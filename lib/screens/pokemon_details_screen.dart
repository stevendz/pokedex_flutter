import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/services/capitalize_string.dart';
import 'package:pokedex/services/type_color.dart';
import 'package:pokedex/widgets/pokemon_types.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final String image;
  final String id;
  final String name;
  final String primaryType;
  final List<String> types;

  const PokemonDetailsScreen({
    Key key,
    @required this.image,
    @required this.id,
    @required this.name,
    @required this.primaryType,
    @required this.types,
  }) : super(key: key);

  @override
  _PokemonDetailsScreenState createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getTypeColor(widget.primaryType),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              capitalize(widget.name),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 2, color: Colors.blueGrey)],
              ),
            ),
            Text(
              '#' + widget.id,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 2, color: Colors.blueGrey)],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: PokemonTypes(
                types: widget.types,
                displayRow: true,
              ),
            ),
            Expanded(
              child: Hero(
                tag: '${widget.name} image',
                child: SvgPicture.network(
                  widget.image,
                  width: MediaQuery.of(context).size.width * .75,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

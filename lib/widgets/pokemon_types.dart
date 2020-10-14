import 'package:flutter/material.dart';
import 'package:pokedex/widgets/type_bubble.dart';

class PokemonTypes extends StatelessWidget {
  final List types;
  final bool displayRow;
  const PokemonTypes({
    Key key,
    @required this.types,
    @required this.displayRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TypeBubble> typeBubbles = [];
    types.forEach((type) {
      typeBubbles.add(TypeBubble(
        type: type,
      ));
    });
    return displayRow
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: typeBubbles,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: typeBubbles,
          );
  }
}

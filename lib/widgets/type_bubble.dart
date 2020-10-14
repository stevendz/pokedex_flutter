import 'package:flutter/material.dart';
import 'package:pokedex/services/capitalize_string.dart';

class TypeBubble extends StatelessWidget {
  const TypeBubble({
    Key key,
    @required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(50),
      ),
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Text(
        capitalize(type),
        style: TextStyle(
          color: Colors.white,
          shadows: [
            Shadow(blurRadius: 2, color: Colors.blueGrey),
          ],
        ),
      ),
    );
  }
}

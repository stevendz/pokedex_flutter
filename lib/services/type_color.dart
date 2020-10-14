import 'package:flutter/material.dart';

Color getTypeColor(type) {
  Map<String, Color> types = {
    'grass': Color(0xff62d7a3),
    'fire': Color(0xffd96060),
    'water': Color(0xff83acd9),
    'bug': Color(0xffb6c263),
    'normal': Color(0xffd1cfb3),
    'poison': Color(0xffbe89bb),
    'electric': Color(0xffffe885),
    'ground': Color(0xffbca667),
    'fairy': Color(0xffffe6f1),
    'fighting': Color(0xffb46f6c),
    'psychic': Color(0xffe7bccb),
    'rock': Color(0xff938b66),
  };
  return types[type];
}

import 'dart:convert';
import 'package:http/http.dart' as http;

Future fetchPokemon(pokemon) async {
  var result = await http.get(pokemon);
  return json.decode(result.body);
}

Future<List> fetchPokemons() async {
  var result = await http.get('https://pokeapi.co/api/v2/pokemon/?limit=151');
  return json.decode(result.body)['results'];
}

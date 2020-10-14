import 'dart:convert';
import 'package:http/http.dart' as http;

Future fetchPokemon(pokemon) async {
  try {
    http.Response result = await http.get(pokemon);
    return json.decode(result.body);
  } catch (error) {
    print('Error: ' + error.toString());
    return null;
  }
}

Future<List> fetchPokemons() async {
  try {
    http.Response result =
        await http.get('https://pokeapi.co/api/v2/pokemon/?limit=151');
    return json.decode(result.body)['results'];
  } catch (error) {
    print('Error: ' + error.toString());
    return null;
  }
}

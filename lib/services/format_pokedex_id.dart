String formatPokedexId(id) {
  String pokedexId = '000' + id;
  return pokedexId.substring(pokedexId.length - 3);
}

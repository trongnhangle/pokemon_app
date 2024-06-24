import '../../data/models/pokemon.dart';
import '../../data/models/pokemon_details.dart';
import '../../utils/typedef.dart';

abstract class PokemonRepository {
  ResultFuture<List<Pokemon>> getPokemonList();
  ResultFuture<PokemonDetails> getPokemonDetails(int pokemonId);
}

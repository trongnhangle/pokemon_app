import 'package:pokemon_challenge/core/data/models/pokemon_details.dart';
import 'package:pokemon_challenge/core/domain/repositories/pokemon_repository.dart';
import 'package:pokemon_challenge/core/utils/typedef.dart';

class GetPokemonDetails {
  final PokemonRepository repository;

  GetPokemonDetails({required this.repository});

  ResultFuture<PokemonDetails> call(int pokemonId) {
    return repository.getPokemonDetails(pokemonId);
  }
}

import 'package:pokemon_challenge/core/data/models/pokemon.dart';
import 'package:pokemon_challenge/core/domain/repositories/pokemon_repository.dart';
import 'package:pokemon_challenge/core/utils/typedef.dart';

class GetPokemonList {
  final PokemonRepository repository;

  GetPokemonList({required this.repository});

  ResultFuture<List<Pokemon>> call() {
    return repository.getPokemonList();
  }
}

import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/core/error/failures.dart';
import 'package:pokemon_challenge/core/data/models/pokemon_details.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';

class GetPokemonDetails {
  final PokemonDetailsRepository repository;

  GetPokemonDetails({required this.repository});

  Future<Either<Failure, PokemonDetails>> call(int pokemonId) async {
    return await repository.getPokemonDetails(pokemonId);
  }
}

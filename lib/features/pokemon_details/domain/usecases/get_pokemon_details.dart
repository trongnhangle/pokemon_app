import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/core/error/failures.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/entities/pokemon_details_entity.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';

class GetPokemonDetails {
  final PokemonDetailsRepository repository;

  GetPokemonDetails({required this.repository});

  Future<Either<Failure, PokemonDetailsEntity>> call(int pokemonId) async {
    return await repository.getPokemonDetails(pokemonId);
  }
}

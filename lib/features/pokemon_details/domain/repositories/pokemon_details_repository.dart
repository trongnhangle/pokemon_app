import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/entities/pokemon_details_entity.dart';
import '../../../../core/error/failures.dart';

abstract class PokemonDetailsRepository {
  Future<Either<Failure, PokemonDetailsEntity>> getPokemonDetails(
      int pokemonId);
}

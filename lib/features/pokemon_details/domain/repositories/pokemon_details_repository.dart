import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/core/error/failures.dart';
import '../../../../core/data/models/pokemon_details.dart';

abstract class PokemonDetailsRepository {
  Future<Either<Failure, PokemonDetails>> getPokemonDetails(int pokemonId);
}

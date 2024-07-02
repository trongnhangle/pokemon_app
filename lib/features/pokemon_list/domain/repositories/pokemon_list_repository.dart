import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/core/error/failures.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/entities/pokemon_entity.dart';

abstract class PokemonListRepository {
  Future<Either<Failure, List<PokemonEntity>>> getPokemonList();
}

import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/core/error/failures.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/repositories/pokemon_list_repository.dart';
import '../entities/pokemon_entity.dart';

class GetPokemonList {
  final PokemonListRepository repository;

  GetPokemonList({required this.repository});

  Future<Either<Failure, List<PokemonEntity>>> call() async {
    return await repository.getPokemonList();
  }
}

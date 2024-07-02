import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/core/error/failures.dart';
import 'package:pokemon_challenge/features/pokemon_list/data/datasources/pokemon_list_remote_data_source.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/entities/pokemon_entity.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/repositories/pokemon_list_repository.dart';

class PokemonListRepositoryImpl implements PokemonListRepository {
  final PokemonListRemoteDataSource remoteDataSource;

  PokemonListRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PokemonEntity>>> getPokemonList() async {
    try {
      final pokemonModels = await remoteDataSource.getPokemonList();
      final pokemonEntities =
          pokemonModels.map((model) => model.toEntity()).toList();
      return Right(pokemonEntities);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'Unknown Error'));
    }
  }
}

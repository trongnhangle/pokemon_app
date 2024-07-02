import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/core/error/failures.dart';
import 'package:pokemon_challenge/features/pokemon_details/data/datasources/pokemon_details_remote_data_source.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/entities/pokemon_details_entity.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';

class PokemonDetailsRepositoryImpl implements PokemonDetailsRepository {
  final PokemonDetailsRemoteDataSource remoteDataSource;

  PokemonDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PokemonDetailsEntity>> getPokemonDetails(
      int pokemonId) async {
    try {
      final pokemonDetailsModel =
          await remoteDataSource.getPokemonDetails(pokemonId);
      return Right(pokemonDetailsModel.toEntity());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'Unknown Error'));
    }
  }
}

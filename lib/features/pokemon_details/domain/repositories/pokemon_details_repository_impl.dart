import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/core/error/failures.dart';
import 'package:pokemon_challenge/features/pokemon_details/data/datasources/pokemon_details_remote_data_source.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';
import '../../../../core/data/models/pokemon_details.dart';

class PokemonDetailsRepositoryImpl implements PokemonDetailsRepository {
  final PokemonDetailsRemoteDataSource remoteDataSource;

  PokemonDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PokemonDetails>> getPokemonDetails(
      int pokemonId) async {
    try {
      final pokemonDetails =
          await remoteDataSource.getPokemonDetails(pokemonId);
      return Right(pokemonDetails);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unknown Error'));
    }
  }
}

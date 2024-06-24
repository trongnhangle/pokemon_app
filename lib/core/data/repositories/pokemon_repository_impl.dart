import '../../domain/repositories/pokemon_repository.dart';
import '../../utils/typedef.dart';
import '../datasources/pokemon_remote_data_source.dart';
import '../models/pokemon.dart';
import '../models/pokemon_details.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<List<Pokemon>> getPokemonList() {
    try {
      final pokemonList = remoteDataSource.getPokemonList();
      return () => pokemonList;
    } catch (e) {
      return () => Future.error(e);
    }
  }

  @override
  ResultFuture<PokemonDetails> getPokemonDetails(int pokemonId) {
    try {
      final pokemonDetails = remoteDataSource.getPokemonDetails(pokemonId);
      return () => pokemonDetails;
    } catch (e) {
      return () => Future.error(e);
    }
  }
}

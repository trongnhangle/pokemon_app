import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_challenge/core/data/datasources/pokemon_remote_data_source.dart';
import 'package:pokemon_challenge/core/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_challenge/core/domain/repositories/pokemon_repository.dart';
import 'package:pokemon_challenge/core/domain/usecases/get_pokemon_details.dart';
import 'package:pokemon_challenge/core/domain/usecases/get_pokemon_list.dart';
import 'package:pokemon_challenge/core/presentation/pokemon_details/pokemon_details_viewmodel.dart';
import 'package:pokemon_challenge/core/presentation/pokemon_list/pokemon_list_viewmodel.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Pokemon List
  sl.registerFactory(
    () => PokemonListViewModel(getPokemonList: sl()),
  );
  sl.registerLazySingleton(() => GetPokemonList(repository: sl()));

  //! Features - Pokemon Details
  sl.registerFactory(
    () => PokemonDetailsViewModel(getPokemonDetails: sl()),
  );
  sl.registerLazySingleton(() => GetPokemonDetails(repository: sl()));

  //! Repository
  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(remoteDataSource: sl()),
  );

  //! Data sources
  sl.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(client: sl()),
  );

  //! External
  sl.registerLazySingleton(() => http.Client());
}

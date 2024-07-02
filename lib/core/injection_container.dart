import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_challenge/features/pokemon_details/data/datasources/pokemon_details_remote_data_source.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/repositories/pokemon_details_repository_impl.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/usecases/get_pokemon_details.dart';
import 'package:pokemon_challenge/features/pokemon_details/presentation/viewmodels/pokemon_details_viewmodel.dart';
import 'package:pokemon_challenge/features/pokemon_list/data/datasources/pokemon_list_remote_data_source.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/repositories/pokemon_list_repository.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/repositories/pokemon_list_repository_impl.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/usecases/get_pokemon_list.dart';
import 'package:pokemon_challenge/features/pokemon_list/presentation/viewmodels/pokemon_list_viewmodel.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Pokemon List
  sl.registerFactory(
    () => PokemonListViewModel(getPokemonList: sl()),
  );
  sl.registerLazySingleton(() => GetPokemonList(repository: sl()));
  sl.registerLazySingleton<PokemonListRepository>(
    () => PokemonListRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<PokemonListRemoteDataSource>(
    () => PokemonListRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Pokemon Details
  sl.registerFactory(
    () => PokemonDetailsViewModel(getPokemonDetails: sl()),
  );
  sl.registerLazySingleton(() => GetPokemonDetails(repository: sl()));
  sl.registerLazySingleton<PokemonDetailsRepository>(
    () => PokemonDetailsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<PokemonDetailsRemoteDataSource>(
    () => PokemonDetailsRemoteDataSourceImpl(client: sl()),
  );

  //! External
  sl.registerLazySingleton(() => http.Client());
}

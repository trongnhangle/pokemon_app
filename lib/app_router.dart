import 'package:go_router/go_router.dart';
import 'package:pokemon_challenge/features/pokemon_details/presentation/screens/pokemon_details_screen.dart';
import 'package:pokemon_challenge/features/pokemon_list/presentation/screens/pokemon_list_screen.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/entities/pokemon_entity.dart';

class AppRouter {
  static const pokemonList = '/';
  static const pokemonDetails = '/details';

  static final router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: pokemonList,
        builder: (context, state) => const PokemonListScreen(),
      ),
      GoRoute(
        path: pokemonDetails,
        builder: (context, state) {
          final pokemon = state.extra as PokemonEntity;
          return PokemonDetailsScreen(pokemon: pokemon);
        },
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_challenge/app_router.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/entities/pokemon_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonListItem extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonListItem({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: pokemon.imageUrl,
        fit: BoxFit.cover,
        width: 50,
        height: 50,
        placeholder: (context, url) => Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(pokemon.name),
      onTap: () {
        context.go('${AppRouter.pokemonDetails}?id=${pokemon.id}',
            extra: pokemon);
      },
    );
  }
}

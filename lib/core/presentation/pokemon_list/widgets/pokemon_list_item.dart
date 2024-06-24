import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/data/models/pokemon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../pokemon_details/pokemon_details_screen.dart';

class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailsScreen(pokemon: pokemon),
          ),
        );
      },
    );
  }
}

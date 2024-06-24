import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/data/models/pokemon.dart';

import '../../pokemon_details/pokemon_details_screen.dart';

class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonListItem({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(pokemon.imageUrl),
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

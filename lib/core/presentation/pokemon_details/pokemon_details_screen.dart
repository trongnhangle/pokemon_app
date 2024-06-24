import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/data/models/pokemon.dart';
import 'package:pokemon_challenge/core/presentation/pokemon_details/pokemon_details_viewmodel.dart';
import 'package:provider/provider.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailsScreen({Key? key, required this.pokemon})
      : super(key: key);

  @override
  _PokemonDetailsScreenState createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<PokemonDetailsViewModel>()
        .fetchPokemonDetails(widget.pokemon.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name),
      ),
      body: Consumer<PokemonDetailsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(viewModel.pokemonDetails!.imageUrl),
                  Text(
                    'Height: ${viewModel.pokemonDetails!.height / 10} m',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Weight: ${viewModel.pokemonDetails!.weight / 10} kg',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Types:',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: viewModel.pokemonDetails!.types
                        .map((type) => Chip(label: Text(type.name)))
                        .toList(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

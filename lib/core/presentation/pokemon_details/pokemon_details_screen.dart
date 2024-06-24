import 'package:cached_network_image/cached_network_image.dart';
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    viewModel.errorMessage!,
                    textAlign: TextAlign.center,
                  ),
                  if (viewModel.errorMessage == 'No Internet connection' ||
                      viewModel.errorMessage == 'Request timed out')
                    ElevatedButton(
                      onPressed: () =>
                          viewModel.fetchPokemonDetails(widget.pokemon.id),
                      child: const Text('Retry'),
                    ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: viewModel.pokemonDetails!.imageUrl,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                    placeholder: (context, url) => Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Text(
                    'Height: ${viewModel.pokemonDetails!.height / 10} m',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Weight: ${viewModel.pokemonDetails!.weight / 10} kg',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Types:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

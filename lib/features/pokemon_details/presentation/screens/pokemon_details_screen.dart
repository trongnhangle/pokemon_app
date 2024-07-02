import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_challenge/app_router.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/entities/pokemon_entity.dart';
import 'package:pokemon_challenge/features/pokemon_details/presentation/viewmodels/pokemon_details_viewmodel.dart';
import 'package:provider/provider.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final PokemonEntity pokemon;

  const PokemonDetailsScreen({Key? key, required this.pokemon})
      : super(key: key);

  @override
  _PokemonDetailsScreenState createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  Future<void>? _pokemonDetailsFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pokemonDetailsFuture = context
          .read<PokemonDetailsViewModel>()
          .fetchPokemonDetails(widget.pokemon.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go(AppRouter.pokemonList);
          },
        ),
      ),
      body: Consumer<PokemonDetailsViewModel>(
        builder: (context, viewModel, child) {
          return FutureBuilder(
            future: _pokemonDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                if (viewModel.pokemonDetails != null) {
                  final pokemonDetails = viewModel.pokemonDetails!;
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: pokemonDetails.imageUrl,
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
                          'Height: ${pokemonDetails.height / 10} m',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Weight: ${pokemonDetails.weight / 10} kg',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Types:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: pokemonDetails.types
                              .map((type) => Chip(label: Text(type.name)))
                              .toList(),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('No data'));
                }
              }
            },
          );
        },
      ),
    );
  }
}

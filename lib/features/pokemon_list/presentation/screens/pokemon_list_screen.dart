import 'package:flutter/material.dart';
import 'package:pokemon_challenge/features/pokemon_list/presentation/widgets/pokemon_list_item.dart';
import 'package:pokemon_challenge/features/pokemon_list/presentation/viewmodels/pokemon_list_viewmodel.dart';
import 'package:provider/provider.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({Key? key}) : super(key: key);

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
        () => context.read<PokemonListViewModel>().fetchPokemonList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon List'),
      ),
      body: Consumer<PokemonListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return _buildErrorSection(viewModel);
          } else {
            return ListView.builder(
              itemCount: viewModel.pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = viewModel.pokemonList[index];

                return PokemonListItem(pokemon: pokemon.toModel());
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildErrorSection(PokemonListViewModel viewModel) {
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
              onPressed: () => viewModel.fetchPokemonList(),
              child: const Text('Thử lại'),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/presentation/pokemon_list/widgets/pokemon_list_item.dart';
import 'package:pokemon_challenge/core/presentation/pokemon_list/pokemon_list_viewmodel.dart';
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
            return Center(child: Text(viewModel.errorMessage!));
          } else {
            return ListView.builder(
              itemCount: viewModel.pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = viewModel.pokemonList[index];
                return PokemonListItem(pokemon: pokemon);
              },
            );
          }
        },
      ),
    );
  }
}

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
    // Lấy dữ liệu Pokemon khi khởi tạo màn hình
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
                  // Thêm nút "Thử lại"
                  if (viewModel.errorMessage == 'No Internet connection' ||
                      viewModel.errorMessage == 'Request timed out')
                    ElevatedButton(
                      onPressed: () => viewModel.fetchPokemonList(),
                      child: const Text('Thử lại'),
                    ),
                ],
              ),
            );
          } else {
            // Hiển thị danh sách Pokemon khi thành công
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

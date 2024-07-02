import 'package:flutter/material.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/entities/pokemon_entity.dart';
import 'package:pokemon_challenge/features/pokemon_list/domain/usecases/get_pokemon_list.dart';

class PokemonListViewModel extends ChangeNotifier {
  final GetPokemonList getPokemonList;

  PokemonListViewModel({required this.getPokemonList});

  List<PokemonEntity> _pokemonList = [];
  List<PokemonEntity> get pokemonList => _pokemonList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPokemonList() async {
    _isLoading = true;
    notifyListeners();

    final result = getPokemonList();

    result.then((either) {
      either.fold(
        (failure) {
          _errorMessage = failure.message;
        },
        (pokemonList) {
          _pokemonList = pokemonList;
        },
      );
    }).catchError((error) {
      _errorMessage = 'Unknown Error: ${error.toString()}';
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}

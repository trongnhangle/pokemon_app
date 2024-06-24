import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/data/models/pokemon.dart';
import 'package:pokemon_challenge/core/domain/usecases/get_pokemon_list.dart';

class PokemonListViewModel extends ChangeNotifier {
  final GetPokemonList getPokemonList;

  PokemonListViewModel({required this.getPokemonList});

  List<Pokemon> _pokemonList = [];
  List<Pokemon> get pokemonList => _pokemonList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPokemonList() async {
    _isLoading = true;
    notifyListeners();

    final result = getPokemonList();

    result().then((pokemonList) {
      _pokemonList = pokemonList;
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _errorMessage = error.toString();
      _isLoading = false;
      notifyListeners();
    });
  }
}

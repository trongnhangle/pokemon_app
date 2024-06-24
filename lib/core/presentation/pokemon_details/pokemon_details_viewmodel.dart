import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/data/models/pokemon_details.dart';
import 'package:pokemon_challenge/core/domain/usecases/get_pokemon_details.dart';

class PokemonDetailsViewModel extends ChangeNotifier {
  final GetPokemonDetails getPokemonDetails;

  PokemonDetailsViewModel({required this.getPokemonDetails});

  PokemonDetails? _pokemonDetails;
  PokemonDetails? get pokemonDetails => _pokemonDetails;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPokemonDetails(int pokemonId) async {
    _isLoading = true;
    notifyListeners();

    final result = getPokemonDetails(pokemonId);

    result().then((pokemonDetails) {
      _pokemonDetails = pokemonDetails;
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _errorMessage = error.toString();
      _isLoading = false;
      notifyListeners();
    });
  }
}

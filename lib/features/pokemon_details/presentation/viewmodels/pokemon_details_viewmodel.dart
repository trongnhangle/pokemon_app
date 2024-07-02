import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/data/models/pokemon_details.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/usecases/get_pokemon_details.dart';

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

    result.then((either) {
      either.fold(
        (failure) {
          _errorMessage = failure.message;
        },
        (pokemonDetails) {
          _pokemonDetails = pokemonDetails;
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

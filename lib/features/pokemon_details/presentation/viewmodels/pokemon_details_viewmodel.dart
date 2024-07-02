import 'package:flutter/material.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/entities/pokemon_details_entity.dart';
import 'package:pokemon_challenge/features/pokemon_details/domain/usecases/get_pokemon_details.dart';

class PokemonDetailsViewModel extends ChangeNotifier {
  final GetPokemonDetails getPokemonDetails;

  PokemonDetailsViewModel({required this.getPokemonDetails});

  PokemonDetailsEntity? _pokemonDetails;
  PokemonDetailsEntity? get pokemonDetails => _pokemonDetails;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPokemonDetails(int pokemonId) async {
    _isLoading = true;
    notifyListeners();

    final result = await getPokemonDetails(pokemonId);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
      },
      (pokemonDetails) {
        _pokemonDetails = pokemonDetails;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';
import '../models/pokemon_details.dart';

abstract class PokemonRemoteDataSource {
  Future<List<Pokemon>> getPokemonList();

  Future<PokemonDetails> getPokemonDetails(int pokemonId);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Pokemon>> getPokemonList() async {
    final response =
        await client.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/'));

    if (response.statusCode == 200) {
      final pokemonListJson = json.decode(response.body)['results'] as List;
      final pokemonList = pokemonListJson.map((pokemonJson) async {
        final pokemonResponse =
            await client.get(Uri.parse(pokemonJson['url'] as String));

        if (pokemonResponse.statusCode == 200) {
          return Pokemon.fromJson(json.decode(pokemonResponse.body));
        } else {
          throw Exception('Failed to load Pokemon');
        }
      }).toList();

      return await Future.wait(pokemonList);
    } else {
      throw Exception('Failed to load Pokemon List');
    }
  }

  @override
  Future<PokemonDetails> getPokemonDetails(int pokemonId) async {
    final response = await client
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonId'));

    if (response.statusCode == 200) {
      return PokemonDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Pokemon Details');
    }
  }
}

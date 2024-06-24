import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
    try {
      final response = await client
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final pokemonListJson = json.decode(response.body)['results'] as List;
        final pokemonList = pokemonListJson.map((pokemonJson) async {
          final pokemonResponse = await client
              .get(Uri.parse(pokemonJson['url'] as String))
              .timeout(const Duration(seconds: 10));

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
    } on SocketException {
      throw Exception('No Internet connection');
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (e) {
      throw Exception('Failed to load Pokemon List: $e');
    }
  }

  @override
  Future<PokemonDetails> getPokemonDetails(int pokemonId) async {
    try {
      final response = await client
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonId'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return PokemonDetails.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Pokemon Details');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (e) {
      throw Exception('Failed to load Pokemon Details: $e');
    }
  }
}

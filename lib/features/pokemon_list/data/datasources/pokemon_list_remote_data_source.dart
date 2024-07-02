import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pokemon_challenge/features/pokemon_list/data/models/pokemon_model.dart';

abstract class PokemonListRemoteDataSource {
  Future<List<PokemonModel>> getPokemonList();
}

class PokemonListRemoteDataSourceImpl implements PokemonListRemoteDataSource {
  final http.Client client;

  PokemonListRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PokemonModel>> getPokemonList() async {
    try {
      final response = await client
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = jsonDecode(response.body);
        final List<dynamic> pokemonListJson = jsonBody['results'];
        final List<PokemonModel> pokemonList = await Future.wait(
          pokemonListJson.map((pokemonJson) async {
            final pokemonResponse =
                await client.get(Uri.parse(pokemonJson['url']));
            if (pokemonResponse.statusCode == 200) {
              return PokemonModel.fromJson(jsonDecode(pokemonResponse.body));
            } else {
              throw Exception('Failed to load Pokemon details');
            }
          }).toList(),
        );

        return pokemonList;
      } else {
        throw Exception('Failed to load Pokemon List');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (e) {
      print('Error in getPokemonList: $e');
      throw Exception('Failed to load Pokemon List: $e');
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../core/data/models/pokemon_details.dart';

abstract class PokemonDetailsRemoteDataSource {
  Future<PokemonDetails> getPokemonDetails(int pokemonId);
}

class PokemonDetailsRemoteDataSourceImpl
    implements PokemonDetailsRemoteDataSource {
  final http.Client client;

  PokemonDetailsRemoteDataSourceImpl({required this.client});

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

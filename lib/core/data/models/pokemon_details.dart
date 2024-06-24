import 'package:equatable/equatable.dart';
import 'pokemon_type.dart';

class PokemonDetails extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<PokemonType> types;

  const PokemonDetails({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.types,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>;
    final other = sprites['other'] as Map<String, dynamic>;
    final officialArtwork = other['official-artwork'] as Map<String, dynamic>;
    final types = (json['types'] as List)
        .map((typeJson) => PokemonType.fromJson(typeJson))
        .toList();

    return PokemonDetails(
      id: json['id'],
      name: json['name'],
      imageUrl: officialArtwork['front_default'],
      height: json['height'],
      weight: json['weight'],
      types: types,
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, height, weight, types];
}

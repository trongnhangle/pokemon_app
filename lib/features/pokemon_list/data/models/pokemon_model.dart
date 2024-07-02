import 'package:pokemon_challenge/features/pokemon_list/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>;
    final other = sprites['other'] as Map<String, dynamic>;
    final officialArtwork = other['official-artwork'] as Map<String, dynamic>;

    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: officialArtwork['front_default'],
    );
  }

  factory PokemonModel.fromEntity(PokemonEntity entity) {
    return PokemonModel(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
    );
  }

  PokemonEntity toEntity() {
    return PokemonEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
    );
  }
}

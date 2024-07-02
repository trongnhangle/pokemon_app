import 'package:pokemon_challenge/features/pokemon_details/domain/entities/pokemon_details_entity.dart';
import 'pokemon_type_model.dart';

class PokemonDetailsModel extends PokemonDetailsEntity {
  const PokemonDetailsModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.height,
    required super.weight,
    required super.types,
  });

  factory PokemonDetailsModel.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>;
    final other = sprites['other'] as Map<String, dynamic>;
    final officialArtwork = other['official-artwork'] as Map<String, dynamic>;
    final types = (json['types'] as List)
        .map((typeJson) => PokemonTypeModel.fromJson(typeJson))
        .toList();

    return PokemonDetailsModel(
      id: json['id'],
      name: json['name'],
      imageUrl: officialArtwork['front_default'],
      height: json['height'],
      weight: json['weight'],
      types: types,
    );
  }

  factory PokemonDetailsModel.fromEntity(PokemonDetailsEntity entity) {
    return PokemonDetailsModel(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      height: entity.height,
      weight: entity.weight,
      types: entity.types
          .map((typeEntity) => PokemonTypeModel.fromEntity(typeEntity))
          .toList(),
    );
  }

  PokemonDetailsEntity toEntity() {
    return PokemonDetailsEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      height: height,
      weight: weight,
      types: types
          .map((typeModel) => PokemonTypeModel(name: typeModel.name))
          .toList(),
    );
  }
}

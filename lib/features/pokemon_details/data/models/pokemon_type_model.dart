import 'package:pokemon_challenge/features/pokemon_details/domain/entities/pokemon_type_entity.dart';

class PokemonTypeModel extends PokemonTypeEntity {
  const PokemonTypeModel({
    required super.name,
  });

  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as Map<String, dynamic>;

    return PokemonTypeModel(
      name: type['name'],
    );
  }

  factory PokemonTypeModel.fromEntity(PokemonTypeEntity entity) {
    return PokemonTypeModel(
      name: entity.name,
    );
  }

  PokemonTypeEntity toEntity() {
    return PokemonTypeEntity(
      name: name,
    );
  }
}

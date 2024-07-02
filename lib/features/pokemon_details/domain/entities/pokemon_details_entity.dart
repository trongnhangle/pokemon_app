import 'package:equatable/equatable.dart';

import '../../data/models/pokemon_type_model.dart';

class PokemonDetailsEntity extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<PokemonTypeModel> types;

  const PokemonDetailsEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.types,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, height, weight, types];
}

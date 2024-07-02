import 'package:equatable/equatable.dart';
import 'package:pokemon_challenge/features/pokemon_list/data/models/pokemon_model.dart';

class PokemonEntity extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  const PokemonEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, imageUrl];

  PokemonModel toModel() {
    return PokemonModel(
      id: id,
      name: name,
      imageUrl: imageUrl,
    );
  }
}

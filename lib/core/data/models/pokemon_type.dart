import 'package:equatable/equatable.dart';

class PokemonType extends Equatable {
  final String name;

  const PokemonType({
    required this.name,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as Map<String, dynamic>;
    return PokemonType(
      name: type['name'],
    );
  }

  @override
  List<Object?> get props => [name];
}

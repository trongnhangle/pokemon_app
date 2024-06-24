import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  const Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>;
    final other = sprites['other'] as Map<String, dynamic>;
    final officialArtwork = other['official-artwork'] as Map<String, dynamic>;

    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: officialArtwork['front_default'],
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl];
}

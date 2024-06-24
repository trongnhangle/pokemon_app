import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/injection_container.dart' as di;
import 'package:pokemon_challenge/core/presentation/pokemon_list/pokemon_list_viewmodel.dart';
import 'package:pokemon_challenge/core/presentation/pokemon_list/pokemon_list_screen.dart';
import 'package:provider/provider.dart';

import 'core/presentation/pokemon_details/pokemon_details_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<PokemonListViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<PokemonDetailsViewModel>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokemon App',
        home: PokemonListScreen(),
      ),
    );
  }
}

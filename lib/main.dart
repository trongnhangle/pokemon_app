import 'package:flutter/material.dart';
import 'package:pokemon_challenge/app_router.dart';
import 'package:pokemon_challenge/core/injection_container.dart' as di;
import 'package:pokemon_challenge/features/pokemon_details/presentation/viewmodels/pokemon_details_viewmodel.dart';
import 'package:pokemon_challenge/features/pokemon_list/presentation/viewmodels/pokemon_list_viewmodel.dart';
import 'package:provider/provider.dart';

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
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Pokemon App',
        routerConfig: AppRouter.router,
      ),
    );
  }
}

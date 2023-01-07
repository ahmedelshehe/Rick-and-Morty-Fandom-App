import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/characters_cubit.dart';
import 'package:rick_and_morty/data/web_services/characters_web_service.dart';
import 'package:rick_and_morty/presentation/screens/character_details.dart';
import 'package:rick_and_morty/presentation/screens/characters_screen.dart';

import 'constants/strings.dart';
import 'data/models/character.dart';
import 'data/repository/characters_repository.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebService());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                charactersCubit,
            child:const CharactersScreen() ,
          ),
        );
      case characterDetailsScreen:
        return MaterialPageRoute(
            builder: (_) =>  CharacterDetailsScreen(character: settings.arguments as Character,));
      default:
        return MaterialPageRoute(builder: (_) => const CharactersScreen());
    }
  }
}

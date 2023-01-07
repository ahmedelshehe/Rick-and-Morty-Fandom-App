import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app_router.dart';
import 'package:rick_and_morty/business_logic/characters_cubit.dart';
import 'package:rick_and_morty/business_logic/global_cubit/global_cubit.dart';
import 'package:rick_and_morty/constants/colors.dart';
import 'package:rick_and_morty/data/repository/characters_repository.dart';
import 'package:rick_and_morty/data/repository/episodes_repository.dart';
import 'package:rick_and_morty/data/web_services/characters_web_service.dart';
import 'package:rick_and_morty/data/web_services/episodes_web_services.dart';
import 'package:sizer/sizer.dart';

import 'constants/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(RickAndMortyApp(appRouter: AppRouter(),));
}

class RickAndMortyApp extends StatelessWidget {
  final AppRouter appRouter;

  const RickAndMortyApp({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharactersCubit>(create:(context)=> CharactersCubit(CharactersRepository(CharactersWebService()))),
        BlocProvider<GlobalCubit>(create: (context)=>GlobalCubit(EpisodesRepository(EpisodesWebService())))
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
         return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Rick and Morty',
            onGenerateRoute: appRouter.onGenerateRoute,
          );
    }),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/episode.dart';
import '../../data/repository/episodes_repository.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit(this.episodesRepository) : super(GlobalInitial());
  List<String> titles =[
    'Characters','Episodes'
  ];
  List<Episode> episodes =[];
  final EpisodesRepository episodesRepository;
  static GlobalCubit get(context) => BlocProvider.of<GlobalCubit>(context);
  int currentIndex = 0;

  void changeIndex(int index){
    currentIndex =index;
    emit(GlobalChangeBottomNavBarState());
  }
  Future<List<Episode>> getAllEpisodes() async{
    await episodesRepository.getAllEpisodes().then((value) {
      emit(EpisodesLoadingState());
      episodes =value;
      emit(EpisodesLoadedState());
    }).catchError((e){
      emit(GlobalErrorState());
    });
    return episodes;
  }
}

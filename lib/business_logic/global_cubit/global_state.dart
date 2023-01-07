part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}
class GlobalChangeBottomNavBarState extends GlobalState {}
class EpisodesLoadedState extends GlobalState {}
class EpisodesLoadingState extends GlobalState {}
class GlobalErrorState extends GlobalState {}

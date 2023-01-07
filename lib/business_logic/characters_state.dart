part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharacterLoaded extends CharactersState{
  final List<Character> characters;
  CharacterLoaded(this.characters);
}
class SearchLoaded extends CharactersState{
  final List<Character> characters;
  SearchLoaded(this.characters);
}
class SearchLoading extends CharactersState{
  SearchLoading();
}
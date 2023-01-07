import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/character.dart';
import '../data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters =[];
  List<Character> searchedCharacters=[];
  bool isSearch=false;
  String searchedName='morty';

  static CharactersCubit get(context) =>BlocProvider.of<CharactersCubit>(context);

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  List<Character> getAllCharacters(int page) {
    charactersRepository.getAllCharacters(page).then((characters) {
      this.characters.addAll(characters);
      emit(CharacterLoaded(this.characters));
    });
    return characters;
  }
  List<Character> searchCharacter(){
    charactersRepository.searchCharacter(searchedName).then((characters) {

      this.searchedCharacters = characters;
      emit(SearchLoaded(this.searchedCharacters));
    });
    return this.searchedCharacters;
  }

}

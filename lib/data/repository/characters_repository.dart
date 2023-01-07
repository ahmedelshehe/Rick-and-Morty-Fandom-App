import 'package:rick_and_morty/data/models/character.dart';

import '../web_services/characters_web_service.dart';

class CharactersRepository{
  final CharactersWebService charactersWebService;
  CharactersRepository(this.charactersWebService);
  Future<List<Character>> getAllCharacters(int page) async{
    final characters =await charactersWebService.getAllCharacters(page);
    return characters.map((character) => Character.fromJson(character)).toList();
  }
  Future<List<Character>> searchCharacter(String name) async{
    final characters=await charactersWebService.searchCharacter(name);
    return characters.map((character) => Character.fromJson(character)).toList();
  }
}
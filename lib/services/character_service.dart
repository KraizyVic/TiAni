import 'dart:convert';
import 'package:http/http.dart'as http;

import '../models/character_model.dart';

class CharacterService{
  Future <List<CharacterModel>> getCharacters(int mal_id) async{
    String characterUrl = "https://api.jikan.moe/v4/anime/${mal_id}/characters";
    final response = await http.get(Uri.parse(characterUrl));
    if(response.statusCode == 200){
      final decodedCharacters = jsonDecode(response.body)["data"]as List;
      //print(decodedCharacters);
      return decodedCharacters.map((character)=>CharacterModel.fromJson(character)).toList();
    }else{
      throw Exception("Failed to load");
    }
  }
}
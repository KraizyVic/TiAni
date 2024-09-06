
class CharacterModel {
  final int mal_id;
  final String name;
  final String image;
  final String role;
  final int favorites;
  final List<VoiceActor> voiceActors;

  CharacterModel({
    required this.mal_id,
    required this.name,
    required this.image,
    required this.role,
    required this.favorites,
    required this.voiceActors,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
    mal_id: json["character"]["mal_id"]??00,
    name: json["character"]["name"]??"Null",
    image: json["character"]["images"]["jpg"]["image_url"]??"https://images4.alphacoders.com/111/thumbbig-1112635.webp",
    role: json["role"]??"Null",
    favorites: json["favorites"]??00,
    voiceActors: List<VoiceActor>.from(json["voice_actors"].map((x) => VoiceActor.fromJson(x))),
  );
}

class VoiceActor {
  final int mal_id;
  final String name;
  final String image;
  final String language;

  VoiceActor({
    required this.mal_id,
    required this.name,
    required this.image,
    required this.language,
  });

  factory VoiceActor.fromJson(Map<String, dynamic> json) => VoiceActor(
    mal_id: json["person"]["mal_id"]??00,
    name: json["person"]["name"]??"Null",
    image: json["person"]["images"]["jpg"]["image_url"]??"https://images4.alphacoders.com/111/thumbbig-1112635.webp",
    language: json["language"]??"Null",
  );
}
class AnimeModel{
  final int malId;
  final String url;
  final String image;
  final String trailer;
  final String trailerImage;
  final bool approved;
  final String title;
  final String titleEnglish;
  final String titleJapanese;
  //final List<String> titleSynonyms;
  final String type;
  final String source;
  final int episodes;
  final String status;
  final bool airing;
  final String duration;
  final String rating;
  final double score;
  final int scoredBy;
  final int rank;
  final int popularity;
  final int members;
  final int favorites;
  final String synopsis;
  //final String background;
  final String season;
  final int year;
  //final Broadcast broadcast;
  final List<PLGSTD> producers;
  final List<PLGSTD> licensors;
  final List<PLGSTD> studios;
  final List<PLGSTD> genres;
  //final List<dynamic> explicitGenres;
  final List<PLGSTD> themes;
  final List<PLGSTD> demographics;

  AnimeModel({
    required this.malId,
    required this.url,
    required this.image,
    required this.trailer,
    required this.trailerImage,
    required this.approved,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    //required this.titleSynonyms,
    required this.type,
    required this.source,
    required this.episodes,
    required this.status,
    required this.airing,
    required this.duration,
    required this.rating,
    required this.score,
    required this.scoredBy,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    //required this.background,
    required this.season,
    required this.year,
    //required this.broadcast,
    required this.producers,
    required this.licensors,
    required this.studios,
    required this.genres,
    //required this.explicitGenres,
    required this.themes,
    required this.demographics,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) => AnimeModel(
    malId: json["mal_id"]??0,
    url: json["url"]??"Null",
    image: json["images"]["jpg"]["large_image_url"]??"Null",
    trailer: json["trailer"]["url"]??"Null",
    trailerImage: json["trailer"]["images"]["maximum_image_url"]??json["images"]["jpg"]["large_image_url"],//"https://images4.alphacoders.com/111/1112635.png"
    approved: json["approved"]??false,
    title: json["title"]??"Null",
    titleEnglish: json["title_english"]??json["title"]??"Null",
    titleJapanese: json["title_japanese"]??json["title"]??"Null",
    //titleSynonyms: List<String>.from(json["title_synonyms"].map((x) => x)),
    type: json["type"]??"Null",
    source: json["source"]??"Null",
    episodes: json["episodes"] ?? 0,
    status: json["status"]??"Null",
    airing: json["airing"]??false,
    duration: json["duration"]??"Null",
    rating: json["rating"]??"Null",
    score: json["score"]?.toDouble()??0,
    scoredBy: json["scored_by"]??0,
    rank: json["rank"]??0,
    popularity: json["popularity"]??0,
    members: json["members"]??0,
    favorites: json["favorites"]??0,
    synopsis: json["synopsis"]??"Null",
    //background: json["background"],
    season: json["season"] ?? "NULL",
    year: json["year"] ?? json["aired"]["prop"]["from"]["year"]??0,
    //broadcast: Broadcast.fromJson(json["broadcast"]),
    producers: List<PLGSTD>.from(json["producers"].map((x) => PLGSTD.fromJson(x))),
    licensors: List<PLGSTD>.from(json["licensors"].map((x) => PLGSTD.fromJson(x))),
    studios: List<PLGSTD>.from(json["studios"].map((x) => PLGSTD.fromJson(x))),
    genres: List<PLGSTD>.from(json["genres"].map((x) => PLGSTD.fromJson(x))),
    //explicitGenres: List<dynamic>.from(json["explicit_genres"].map((x) => x)),
    themes: List<PLGSTD>.from(json["themes"].map((x) => PLGSTD.fromJson(x))),
    demographics: List<PLGSTD>.from(json["demographics"].map((x) => PLGSTD.fromJson(x))),
  );
}
class PLGSTD{
  final int mal_id;
  final String type;
  final String name;
  final String url;
  PLGSTD({
    required this.mal_id,
    required this.type,
    required this.name,
    required this.url,
  });
  factory PLGSTD.fromJson(Map<String,dynamic>json){
    return PLGSTD(
      mal_id: json["mal_id"]??00,
      type: json["type"]??"Unknown",
      name: json["name"]??"Unknown",
      url: json["url"]??"Unknown",
    );
  }
}

class Related{
  final int mal_id;
  final String image;
  final int votes;
  Related({
    required this.mal_id,
    required this.image,
    required this.votes,
  });
}
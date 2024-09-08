
class ReviewModel {
  final int malId;
  final String url;
  final String type;
  final ReactionModel reactions;
  final String tag;
  final String date;
  final String review;
  final int score;
  final bool isSpoiler;
  final bool isPreliminary;
  final int episodesWatched;
  final String userUrl;
  final String userName;
  final String image;

  ReviewModel({
    required this.malId,
    required this.url,
    required this.type,
    required this.reactions,
    required this.tag,
    required this.date,
    required this.review,
    required this.score,
    required this.isSpoiler,
    required this.isPreliminary,
    required this.episodesWatched,
    required this.userUrl,
    required this.userName,
    required this.image,
  });

  factory ReviewModel.fromJson(Map<String,dynamic>json) => ReviewModel(
      malId: json["malId"]??00,
      url: json["url"]??"Null",
      type: json["type"]??"Null",
      reactions: ReactionModel.fromJson(json["reactions"]),
      tag: json["tags"][0]??"Null",
      date: json["date"]??"Null",
      review: json["review"]??"Null",
      score: json["score"]??00,
      isSpoiler: json["is_spoiler"]??false,
      isPreliminary: json["is_preliminary"]??false,
      episodesWatched: json["episodes_watched"]??00,
      userUrl: json["user"]["url"]??"Null",
      userName: json["user"]["username"]??"Null",
      image: json["user"]["images"]["jpg"]["image_url"]??"https://www.deviantart.com/jo-art1/art/404-Not-Found-Tshirt-Design-PNG-1079062518",
  );
}
class ReactionModel{
  final int overall;
  final int nice;
  final int loveIt;
  final int funny;
  final int confusing;
  final int informative;
  final int wellWritten;
  final int creative;

  ReactionModel({
    required this.overall,
    required this.nice,
    required this.loveIt,
    required this.funny,
    required this.confusing,
    required this.informative,
    required this.wellWritten,
    required this.creative,
  });

  factory ReactionModel.fromJson(Map<String,dynamic>json) => ReactionModel(
      overall: json["overall"]??00,
      nice: json["nice"]??00,
      loveIt: json["love_it"]??00,
      funny: json["funny"]??00,
      confusing: json["confusing"]??00,
      informative: json["informative"]??00,
      wellWritten: json["well_written"]??00,
      creative: json["creative"]??00,
  );
}

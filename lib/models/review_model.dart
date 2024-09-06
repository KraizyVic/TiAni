import 'dart:convert';

class ReviewModel {
  final int malId;
  final String url;
  final String type;
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

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
      malId: json["malId"]??00,
      url: json["url"]??"Null",
      type: json["type"]??"Null",
      date: json["date"]??"Null",
      review: json["review"]??"Null",
      score: json["score"]??00,
      isSpoiler: json["is_spoiler"]??false,
      isPreliminary: json["is_prelminary"]??false,
      episodesWatched: json["episodes_watched"]??00,
      userUrl: json["user"]["url"]??"Null",
      userName: json["user"]["username"]??"Null",
      image: json["user"]["images"]["jpg"]["image_url"]??"https://www.deviantart.com/jo-art1/art/404-Not-Found-Tshirt-Design-PNG-1079062518",
  );
}

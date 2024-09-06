
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:tiani/models/review_model.dart';
import '../models/anime_model.dart';
class AnimeService{
  // TOTAL ANIMES
  String animes = "https://api.jikan.moe/v4/anime";
  Future<List<AnimeModel>> getAllAnimes()async{
    final response = await http.get(Uri.parse(animes));
    if(response.statusCode == 200){
      final decodedAnimes = jsonDecode(response.body)["data"] as List;
      //print(decodedAnimes);
      return decodedAnimes.map((animes)=>AnimeModel.fromJson(animes)).toList();
    }else{
      throw Exception("Error getting  ${response.statusCode}");
    }
  }
  // IN SEASON ANIMES
  String seasonsNow = "https://api.jikan.moe/v4/seasons/now";
  Future<List<AnimeModel>> getInSeasonAnimes()async{
    final response = await http.get(Uri.parse(seasonsNow));
    if(response.statusCode == 200){
      final decodedAnimes = jsonDecode(response.body)["data"] as List;
      //print(decodedAnimes);
      return decodedAnimes.map((anime)=>AnimeModel.fromJson(anime)).toList();
    }else{
      throw Exception("Error getting your shit  ${response.statusCode}");
    }
  }

  // Fetch Airing Animes
  String airing = "https://api.jikan.moe/v4/top/anime?filter=airing";
  Future<List<AnimeModel>> getAiringAnimes()async{
    final response = await http.get(Uri.parse(airing));
    if(response.statusCode == 200){
      final decodedAnimes = jsonDecode(response.body)["data"] as List;
      //print(decodedAnimes);
      return decodedAnimes.map((anime)=>AnimeModel.fromJson(anime)).toList();
    }else{
      throw Exception("Error getting your shit  ${response.statusCode}");
    }
  }

  // Fetch Popular Animes
  String popular = "https://api.jikan.moe/v4/top/anime?filter=bypopularity";
  Future<List<AnimeModel>> getPopularAnimes()async{
    final response = await http.get(Uri.parse(popular));
    if(response.statusCode == 200){
      final decodedAnimes = jsonDecode(response.body)["data"] as List;
      //print(decodedAnimes);
      return decodedAnimes.map((anime)=>AnimeModel.fromJson(anime)).toList();
    }else{
      throw Exception("Error getting your Shit ${response.statusCode}");
    }
  }

  // Fetch Upcoming Animes
  String upcoming = "https://api.jikan.moe/v4/top/anime?filter=upcoming";
  Future<List<AnimeModel>> getUpcomingAnimes()async{
    final response = await http.get(Uri.parse(upcoming));
    if(response.statusCode == 200){
      final decodedAnimes = jsonDecode(response.body)["data"] as List;
      //print(decodedAnimes);
      return decodedAnimes.map((anime)=>AnimeModel.fromJson(anime)).toList();
    }else{
      throw Exception("Error getting your shit ${response.statusCode}");
    }
  }

  // Fetch Anime Recommendation Per Selected Anime
  Future<List<AnimeModel>> getRecommendedAnimes(int malId)async{
    String recommendations = "https://api.jikan.moe/v4/anime/${malId}/recommendations";
    final response = await http.get(Uri.parse(recommendations));
    if(response.statusCode == 200){
      final decodedAnimes = jsonDecode(response.body)["data"] as List;
      //print(decodedAnimes);
      return decodedAnimes.map((anime)=>AnimeModel.fromJson(anime)).toList();
    }else{
      throw Exception("Error getting your shit ${response.statusCode}");
    }
  }

  // Filter Animes
  Future<List<AnimeModel>> filterAnimes(String filter,String type)async{
    String filterUrl = "https://api.jikan.moe/v4/top/anime?filter=${filter}&type=${type}";
    final response = await http.get(Uri.parse(filterUrl));
    if(response.statusCode == 200){
      final decodedAnimes = jsonDecode(response.body)["data"] as List;
      //print(decodedAnimes);
      return decodedAnimes.map((anime)=>AnimeModel.fromJson(anime)).toList();
    }else{
      throw Exception("Error getting your shit ${response.statusCode}");
    }
  }

  // Search Animes
  Future<List<AnimeModel>> searchAnimes(String search)async{
    String filterUrl = "https://api.jikan.moe/v4/anime?q=${search}&order_by=popularity&sfw=${true}";
    final response = await http.get(Uri.parse(filterUrl));
    if(response.statusCode == 200){
      final decodedAnimes = jsonDecode(response.body)["data"] as List;
      print(decodedAnimes);
      return decodedAnimes.map((anime)=>AnimeModel.fromJson(anime)).toList();
    }else{
      throw Exception("Error getting your shit ${response.statusCode}");
    }
  }

  // Get Anime Reviews
  Future<List<ReviewModel>> getanimeReviews(int malId) async{
    String reviewUrl = "https://api.jikan.moe/v4/anime/${malId}/reviews";
    final response = await http.get(Uri.parse(reviewUrl));
    if(response.statusCode == 200){
      final decodedReviews = jsonDecode(response.body)["data"] as List;
      print(decodedReviews);
      return decodedReviews.map((review)=>ReviewModel.fromJson(review)).toList();
    }else{
      throw Exception("Error");
    }
  }
}
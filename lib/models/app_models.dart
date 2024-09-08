import 'package:tiani/models/anime_model.dart';

class AccountModel{
  final String name;
  final String pfpImage;
  final Set<AnimeModel> watchedFilms;
  final Set<AnimeModel> movieList;
  final Set<AnimeModel> tvList;
  final Set<AnimeModel> uncategorisedList;

  AccountModel({
    required this.name,
    required this.pfpImage,
    required this.watchedFilms,
    required this.movieList,
    required this.tvList,
    required this.uncategorisedList,
  });

}
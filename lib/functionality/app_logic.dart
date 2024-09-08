
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tiani/functionality/data.dart';
import 'package:tiani/models/anime_model.dart';
import 'package:tiani/theme/theme.dart';
import 'package:tiani/utilities/account_items.dart';

import '../models/app_models.dart';

class AppLogic extends ChangeNotifier{

//============= APPEARANCE ====================

  // Change Theme
  var groupvalue = 1;
  var currentTheme = darkTheme;
  void changeTheme(int value){
    groupvalue = value;
    if(groupvalue == 1){
      currentTheme = darkTheme;
    }else{
      currentTheme = lightTheme;
    }
    notifyListeners();
  }
  // Change Colors
  var tertiaryColor = colors[0];
  void changeColor(Color color){
    tertiaryColor = color;
    notifyListeners();
  }
  // Change Background Pic:
  var currentPic = backgroundImages[15];
  void changePic(String backgroundPic){
    currentPic = backgroundPic;
    notifyListeners();
  }
//================= PREFERENCE ================
  var preferrenceGroupValue = 1;
  void changelayout(int value){
    preferrenceGroupValue = value;
    notifyListeners();
  }
  var showCast = true;
  void showcast(value){
    if (showCast != value) {
      showCast = value;
      notifyListeners();
    }
  }
  var showRelated = true;
  void shorelated(value){
    if (showRelated != value) {
      showRelated = value;
      notifyListeners();
    }
  }
  var enableGlassMorphism = false;
  void enableGlassMorphicButtons(value){
    if (enableGlassMorphism != value) {
      enableGlassMorphism = value;
      notifyListeners();
    }
  }
  var backgroundPicInMainPage = false;
  void backgroundMain(value){
    if (backgroundPicInMainPage != value) {
      backgroundPicInMainPage = value;
      notifyListeners();
    }
  }
  var enablePreview = false;
  void enablepreview(value){
    if (enablePreview != value) {
      enablePreview = value;
      notifyListeners();
    }
  }
  var showAppBar = false;
  void showAppbarInHomePage(value){
    if (showAppBar != value) {
      showAppBar = value;
      notifyListeners();
    }
  }
  var showNsfwContent = true;
  void shownsfw(value){
    if (showNsfwContent != value) {
      showNsfwContent = value;
      notifyListeners();
    }
  }

//================= ACCOUNT ===================

  // Account:
  var currentAccount = 0;
  List<AccountModel> accounnts = [
   AccountModel(
       name: "Nancy",
       pfpImage: "",
       watchedFilms: {},
       movieList: {},
       tvList: {},
       uncategorisedList: {},
   ),
  ];
  void addAccount(BuildContext context){
    /*accounnts.add(
      AccountModel(
        name: "Somebady",
        pfpImage: imagesData[2],
        watchedFilms: 0,
        movieList: 0,
        tvList: 0,
        uncategorisedList: 0,
      ),
    );*/
    showDialog(
      context: context,
      builder: (context){
        return AccountDialog();
      },
    );
    notifyListeners();
  }
  void displayAccount(int index){
    currentAccount = index;
    notifyListeners();
  }
  void deleteAccount(){
    if(accounnts.length > 1){
      accounnts.removeAt(currentAccount);
      currentAccount = 0;
    }else{
      currentAccount = 0;
    }
    notifyListeners();
  }
  void deleteListedAccount(int index){
    if(accounnts.length>1){
      accounnts.removeAt(index);
      currentAccount = 0;
    }
    currentAccount = 0;
    notifyListeners();
  }

  // ======== ADD ANIME TO lIST ========
  void addAnimeToList(AnimeModel anime){
    if(anime.type == "Movie"){
      accounnts[currentAccount].movieList.add(anime);
    }else if(anime.type == "TV"){
      accounnts[currentAccount].tvList.add(anime);
    }else{
      accounnts[currentAccount].uncategorisedList.add(anime);
    }
    notifyListeners();
  }
  void removeFromList(AnimeModel anime){
    if(anime.type == "Movie"){
      accounnts[currentAccount].movieList.remove(anime);
    }else if(anime.type == "TV"){
      accounnts[currentAccount].tvList.remove(anime);
    }else{
      accounnts[currentAccount].uncategorisedList.remove(anime);
    }
    notifyListeners();
  }
}
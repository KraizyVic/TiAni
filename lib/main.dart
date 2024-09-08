import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/pages/home_page.dart';
import 'package:tiani/pages/main_page.dart';
import 'package:tiani/pages/welcome_page.dart';
import 'package:tiani/services/anime_service.dart';
import 'package:tiani/services/http_override.dart';
import 'package:tiani/utilities/mods.dart';

import 'models/anime_model.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    ChangeNotifierProvider(
      create: (context)=>AppLogic(),
      child: const MyApp()),
    );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<AnimeModel>> animes;
  @override
  void initState() {
    // TODO: implement initState
    animes = AnimeService().getAllAnimes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child)=> MaterialApp(
        title:  "TiAni",
        theme: Provider.of<AppLogic>(context).currentTheme,
        home: /*MainPage()*/FutureBuilder(
          future: animes,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return MainPage();
            }else{
              return WelcomePage();
            }
          }
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

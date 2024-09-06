import 'package:flutter/material.dart';
import 'package:tiani/services/anime_service.dart';
import 'package:tiani/utilities/constants.dart';
import '../models/anime_model.dart';
import '../utilities/dummy_widgets.dart';
import '../utilities/home_tile.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final FocusNode _airingNode = FocusNode();
  final FocusNode _popular = FocusNode();
  final FocusNode _upcoming = FocusNode();
  late Future<List<AnimeModel>> airing;
  late Future<List<AnimeModel>> popular;
  late Future<List<AnimeModel>> upcoming;

  @override
  void initState() {
    // TODO: implement initState
    airing = AnimeService().filterAnimes("airing", "movie");
    popular = AnimeService().filterAnimes("bypopularity", "movie");
    upcoming = AnimeService().filterAnimes("upcoming", "movie");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _airingNode.dispose();
    _popular.dispose();
    _upcoming.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Airing",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*homeTileHeight,
                child: FutureBuilder(
                  future: airing,
                  builder:(context,snapshot){
                    if(snapshot.hasData){
                      return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.6/1),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                            return HomeTile(
                              anime: snapshot.data![index],
                              focusNode: index == 0 ? _airingNode : FocusNode(),
                              autofocus: false,
                              //onDown: ()=>_popular.requestFocus(),
                            );
                          }
                      );
                    }/*else if (snapshot.hasError){
                      return Center(child: Text("Error"),);
                    }*/
                    else{
                      return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.6/1),
                          itemCount: 10,
                          itemBuilder: (context,index){
                            return DummyHomeTile(
                              focusNode: index == 0 ? _airingNode : FocusNode(),
                              image: "",
                              autofocus: index == 0,
                              onDown: ()=>_popular.requestFocus(),
                            );
                          }
                      );
                    }

                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Popular",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height*homeTileHeight,
                  child: FutureBuilder(
                      future: popular,
                      builder:(context,snapshot){
                        if(snapshot.hasData){
                          return GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.6/1),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                return HomeTile(
                                  anime: snapshot.data![index],
                                  focusNode: index == 0 ? _popular : FocusNode(),
                                  autofocus: false,
                                  onUp: ()=>  _airingNode.requestFocus(),
                                  onDown: ()=>_upcoming.requestFocus(),
                                );
                              }
                          );
                        }/*else if (snapshot.hasError){
                          return Center(child: Text("Error"),);
                        }*/
                        else{
                          return GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.6/1),
                              itemCount: 10,
                              itemBuilder: (context,index){
                                return DummyHomeTile(
                                  focusNode: index == 0 ? _popular : FocusNode(),
                                  image: "",
                                  autofocus: false,
                                  //onUp: ()=> _airingNode.requestFocus(),
                                  onDown: ()=>_upcoming.requestFocus(),
                                );
                              }
                          );
                        }
                      }
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                    "Upcoming",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height*homeTileHeight,
                  child: FutureBuilder(
                      future: upcoming,
                      builder:(context,snapshot){
                        if(snapshot.hasData){
                          return GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.6/1),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                return HomeTile(
                                  anime: snapshot.data![index],
                                  focusNode: index == 0 ? _upcoming : FocusNode(),
                                  autofocus: false,
                                  onUp: ()=>_popular.requestFocus(),
                                );
                              }
                          );
                        }/*else if (snapshot.hasError){
                          print(snapshot.error);
                          return Center(child: Text("Error"),);
                        }*/
                        else{
                          return GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.6/1),
                              itemCount: 10,
                              itemBuilder: (context,index){
                                return DummyHomeTile(
                                  focusNode: index == 0 ? _upcoming : FocusNode(),
                                  image: "",
                                  autofocus: false,
                                  //onUp: ()=>_popular.requestFocus(),
                                );
                              }
                          );
                        }
                      }
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

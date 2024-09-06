import 'package:flutter/material.dart';
import 'package:tiani/utilities/constants.dart';
import '../models/anime_model.dart';
import '../services/anime_service.dart';
import '../utilities/dummy_widgets.dart';
import '../utilities/home_tile.dart';
class SerriePage extends StatefulWidget {
  const SerriePage({super.key});

  @override
  State<SerriePage> createState() => _SerriePageState();
}

class _SerriePageState extends State<SerriePage> {
  final FocusNode _airingNode = FocusNode();
  final FocusNode _popularNode = FocusNode();
  final FocusNode _upcomingNode = FocusNode();

  late Future<List<AnimeModel>> airing;
  late Future<List<AnimeModel>> popular;
  late Future<List<AnimeModel>> upcoming;

  @override
  void initState() {
    // TODO: implement initState
    airing = AnimeService().filterAnimes("airing", "tv");
    popular = AnimeService().filterAnimes("bypopularity", "tv");
    upcoming = AnimeService().filterAnimes("upcoming", "tv");
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _airingNode.dispose();
    _popularNode.dispose();
    _upcomingNode.dispose();
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
                                  autofocus: index == 0,
                                  //onUp: (){},
                                  onDown: ()=>_popularNode.requestFocus(),
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
                                  autofocus: false,
                                  onDown: ()=>_popularNode.requestFocus(),
                                );
                              }
                          );
                        }

                      }
                  )
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
                                  focusNode: index == 0 ? _popularNode : FocusNode(),
                                  autofocus: false,
                                  onUp: ()=>_airingNode.requestFocus(),
                                  onDown: ()=>_upcomingNode.requestFocus(),
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
                                  focusNode: index == 0 ? _popularNode : FocusNode(),
                                  image: "",
                                  autofocus: false,
                                  //onUp: ()=> _airingNode.requestFocus(),
                                  onDown: ()=>_upcomingNode.requestFocus(),
                                );
                              }
                          );
                        }

                      }
                  )
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
                                  focusNode: index == 0 ? _upcomingNode : FocusNode(),
                                  autofocus: index == 0,
                                  onUp: ()=>_popularNode.requestFocus(),
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
                                  focusNode: index == 0 ? _upcomingNode : FocusNode(),
                                  image: "",
                                  autofocus: false,
                                  //onUp: ()=>_popularNode.requestFocus(),
                                );
                              }
                          );
                        }

                      }
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}

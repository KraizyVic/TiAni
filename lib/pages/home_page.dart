import 'package:flutter/material.dart';
import 'package:tiani/services/anime_service.dart';
import 'package:tiani/utilities/constants.dart';
import 'package:tiani/utilities/dummy_widgets.dart';
import 'package:tiani/utilities/home_banner.dart';
import 'package:tiani/utilities/home_tile.dart';
import '../models/anime_model.dart';
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var assetimage = "lib/assets/cybergoth_by_slimshadywallpaper_dhpdkm5-414w-2x.jpg";
  //var autofocus = false;
  final FocusNode popularNode = FocusNode();
  final FocusNode upcomingNode = FocusNode();
  final FocusNode _bannerNode= FocusNode();
  final ScrollController _scrollController = ScrollController();
  late Future<List<AnimeModel>> airing;
  late Future<List<AnimeModel>> popular;
  late Future<List<AnimeModel>> upcoming;
  @override
  void initState() {
    // TODO: implement initState
    airing = AnimeService().getAiringAnimes();
    popular = AnimeService().getPopularAnimes();
    upcoming = AnimeService().getUpcomingAnimes();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    popularNode.dispose();
    upcomingNode.dispose();
    _bannerNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.5,
                  width: double.maxFinite,
                  child: FocusTraversalOrder(
                    order: NumericFocusOrder(0.0),
                    child: FutureBuilder(
                      future: airing,
                      builder:(context , snapshot){
                        if(snapshot.hasData){
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context,index){
                              return HomeBanner(
                                //focusNode: index == 0 ? _bannerNode:FocusNode(),
                                anime: snapshot.data![index],
                                changeFocus: (){},
                                onKeyDown: () {
                                  popularNode.requestFocus();
                                },
                                onKeyUp: (){},
                              );
                            },
                          );
                        }/*else if(snapshot.hasError){
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        }*/
                        else{
                          return DummyHomeBanner(
                            changeFocus: (){},
                            onKeyDown: () =>popularNode.requestFocus(),
                            onKeyUp: (){}
                          );
                        }

                      }
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text("Popular",style: TextStyle(fontSize: 20),),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*homeTileHeight,
                    child: FocusTraversalOrder(
                      order: NumericFocusOrder(1.0),
                      child: FutureBuilder(
                        future: popular,
                        builder:(context,snapshot){
                          if( snapshot.hasData){
                            return GridView.builder(
                                controller: _scrollController,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 1.6/1
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context,index){
                                  return HomeTile(
                                    anime: snapshot.data![index],
                                    focusNode: index == 0 ? popularNode : FocusNode(),
                                    autofocus: false,
                                    onDown: ()=> upcomingNode.requestFocus(),
                                    /*onUp: () {
                                  _bannerNode.requestFocus();
                                },*/
                                  );
                                }
                            );
                          }/*else if (snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()),);
                          }*/
                          else{
                            return GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.6/1),
                                itemCount: 10,
                                itemBuilder: (context,index){
                                  return DummyHomeTile(
                                    focusNode: index == 0 ? popularNode : FocusNode(),
                                    image: "",
                                    autofocus: index == 0,
                                    onDown: ()=>upcomingNode.requestFocus(),
                                  );
                                }
                            );
                          }
                        }
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text("Upcoming",style: TextStyle(fontSize: 20),),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*homeTileHeight,
                    child: FocusTraversalOrder(
                      order: NumericFocusOrder(2.0),
                      child: FutureBuilder(
                        future: upcoming,
                        builder:(context,snapshot){
                          if(snapshot.hasData){
                            return  GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 1.6/1
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context,index){
                                  return HomeTile(
                                    anime: snapshot.data![index],
                                    focusNode: index == 0 ? upcomingNode : FocusNode(),
                                    autofocus: false,
                                    onUp: ()=>popularNode.requestFocus(),
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
                                    focusNode: index == 0 ? upcomingNode : FocusNode(),
                                    image: "",
                                    autofocus: false,
                                    //onUp: ()=>popularNode.requestFocus(),
                                  );
                                }
                            );
                          }
                        }
                      ),
                    )
                )
              ],
            ),
          )
        ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/models/anime_model.dart';
import 'package:tiani/models/character_model.dart';
import 'package:tiani/models/review_model.dart';
import 'package:tiani/services/anime_service.dart';
import 'package:tiani/services/character_service.dart';
import 'package:tiani/utilities/character_tile.dart';
import 'package:tiani/utilities/constants.dart';
import 'package:tiani/utilities/detail_items.dart';
import 'package:tiani/utilities/dummy_widgets.dart';
import 'package:tiani/utilities/mods.dart';
class Intro extends StatelessWidget {
  final AnimeModel anime;
  const Intro({
    super.key,
    required this.anime
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height*0.4,
          child: Row(
            children: [
              Container(
                height: double.maxFinite,
                width: MediaQuery.of(context).size.height*0.4*0.625,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: NetworkImage(anime.image),fit: BoxFit.cover)
                ),
              ),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(anime.type),
                          SizedBox(width: 20,),
                          Text(anime.duration),
                          SizedBox(width: 20,),
                          Row(
                            children: [
                              Icon(Icons.star,size: 20,),
                              SizedBox(width: 7,),
                              Text(anime.score.toString()),
                            ],
                          ),
                          SizedBox(width: 20,),
                          Text(anime.year.toString()),
                        ],
                      ),
                    ),
                    Text(
                      anime.titleEnglish,
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}

class Overview extends StatefulWidget {
  final AnimeModel anime;
  const Overview({
    super.key,
    required this.anime,
  });

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  late Future<List<CharacterModel>> characters;
  @override
  void initState() {
    // TODO: implement initState
    characters = CharacterService().getCharacters(widget.anime.malId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child)=> Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: Text(
                  "Overview",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.anime.titleEnglish,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 30
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      widget.anime.synopsis,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              data.showCast==true?Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Characters",style: TextStyle(fontSize: 17),),
                        ModedIconButton(onPressed: (){}, icon: Icons.chevron_right)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.2,
                    child: SizedBox(
                      child: FutureBuilder(
                        future: characters,
                        builder:(context,snapshot){
                          if(snapshot.hasData){
                            return GridView.builder(
                                itemCount:snapshot.data!.length,
                                scrollDirection: Axis.horizontal,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,),
                                itemBuilder: (context,index){
                                  return CharacterTile(
                                    autofocus: false,
                                    character: snapshot.data![index],
                                  );
                                }
                            );
                          } else if(snapshot.hasError){
                            return Center(child: Text("Error"),);
                          }else{
                            return GridView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,),
                                itemBuilder: (context,index){
                                  return DummyCharacterTile(
                                    autofocus: false,
                                  );
                                }
                            );
                          }
                        }
                    ),
                  ),
                  )
                ],
              ):SizedBox(),

              data.showRelated == true ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Related",style: TextStyle(fontSize: 17)),
                        ModedIconButton(onPressed: (){}, icon: Icons.chevron_right)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*homeTileHeight,
                    child:GridView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.6/1),
                      itemBuilder:  (context,index){
                        return DummyHomeTile(image: "", autofocus: false);
                      },
                    ) ,
                  )
                ],
              ):SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class Seasons extends StatefulWidget {
  final AnimeModel anime;
  const Seasons({super.key,required this.anime});

  @override
  State<Seasons> createState() => _SeasonsState();
}

class _SeasonsState extends State<Seasons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Text(
                "Episodes",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                /*Expanded(
                  child: Container(
                    //color: Colors.red,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context,index)=>SeasonTile(seasonNumber: index+1,)
                    ),
                  ),
                ),*/
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      //color: Colors.blue,
                      child:widget.anime.episodes>0?GridView.builder(
                        itemCount: widget.anime.episodes,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                        itemBuilder: (context,index){
                          return EpisodeTile(episodeNumber: index+1,);
                        },
                      ):Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.not_interested,size: 50,color: Provider.of<AppLogic>(context,listen: false).tertiaryColor,),
                          SizedBox(height: 20,),
                          Text("Nothing to view Here !!"),
                        ],
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}


class Rate extends StatelessWidget {
  const Rate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text("Coming Soon"),
      ),
    );
  }
}

class Reviews extends StatefulWidget {
  final AnimeModel anime;
  final FocusNode reviewNode;
  const Reviews({
    super.key,
    required this.anime,
    required this.reviewNode,
  });

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  late Future<List<ReviewModel>>reviews;
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    reviews = AnimeService().getanimeReviews(widget.anime.malId);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Text(
              "Reviews",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: reviews,
              builder: (context,snapshot){
                if(snapshot.hasData){
                  if(snapshot.data!.length>0){
                    return ListView.builder(
                      itemCount:snapshot.data!.length,
                      itemBuilder: (context,index){
                        return ReviewTile(
                          focusNode: index == 0 ? _focusNode :FocusNode(),
                          review: snapshot.data![index],
                        );
                      },
                    );
                  }else{
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.not_interested,size: 50,color: Provider.of<AppLogic>(context,listen: false).tertiaryColor,),
                          SizedBox(height: 20,),
                          Text("This anime has no reviews"),
                        ],
                      ),
                    );
                  }
                }else if (snapshot.hasError){
                  return Center(child: Text("Error"),);
                }else if (snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(color: Provider.of<AppLogic>(context,listen: false).tertiaryColor,),);
                }else{
                  return ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context,index){
                      return DummyReviewTile();
                    },
                  );
                }
              }
              ),
            ),
        ],
      ),
    );
  }
}




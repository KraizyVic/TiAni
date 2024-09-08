import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/services/anime_service.dart';
import 'package:tiani/utilities/mods.dart';
import 'package:tiani/pages/account_page.dart';
import 'package:tiani/pages/main_page.dart';
import 'package:tiani/pages/settings_page.dart';
import 'package:tiani/utilities/home_tile.dart';

import '../models/anime_model.dart';
import '../utilities/dummy_widgets.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var autofocus = false;
  var autoIndex = 1;
  final FocusNode _focusNode = FocusNode();
  late Future<List<AnimeModel>> searchedAnime;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    searchedAnime = AnimeService().searchAnimes(_controller.text);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }

  void searchAnimes(){
    setState(() {
      searchedAnime= Future.value([]);
      searchedAnime = AnimeService().searchAnimes(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context,data,child)=> Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Image.asset(
              data.currentPic,
              height: double.maxFinite,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
              decoration:BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).canvasColor,Theme.of(context).canvasColor.withOpacity(0.2)],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
            ),
            Column(
              children: [
                ModedAppBar(
                  action1: ModedIconButton(onPressed: ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MainPage())), icon: HugeIcons.strokeRoundedHome09),
                  action2: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>AccountPage())), icon: HugeIcons.strokeRoundedUserCircle),
                  action3: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingsPage())), icon: HugeIcons.strokeRoundedSettings03),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              alignment:Alignment.center,
                              height: double.maxFinite,
                              //color: Colors.blue.withOpacity(0.3),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width*0.4,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _controller,
                                        textAlign: TextAlign.center,
                                        onSubmitted: (action){
                                          setState(() {
                                            _focusNode.requestFocus();
                                            autoIndex = 0;
                                            searchAnimes();
                                            //searchedAnime = AnimeService().searchAnimes(_controller.text);
                                          });
                                        },
                                        autofocus: true,
                                        //textCapitalization: TextCapitalization.characters,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Theme.of(context).canvasColor.withOpacity(0.7),
                                          hintText: "Search",
                                          suffixIcon: Icon(Icons.search,color: Colors.white70,),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1,color: data.tertiaryColor),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1,color: data.tertiaryColor),
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Container(
                        width: 1,
                        color: data.tertiaryColor,
                        height: MediaQuery.of(context).size.height*0.7,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Results",
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    ),
                                    Text("Total: 20",style: TextStyle(fontSize: 12),),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: FutureBuilder(
                                  future: searchedAnime,
                                  builder:(context,snapshot){
                                    if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                                      return Container(
                                        child: (data.preferrenceGroupValue == 1)?GridView.builder(
                                          itemCount: snapshot.data!.length,
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              childAspectRatio: 1/1.6
                                          ),
                                          itemBuilder: (context,index){
                                            return HomeTile(
                                              anime: snapshot.data![index],
                                              focusNode: index == 0?_focusNode:FocusNode(),
                                              autofocus: autofocus,
                                              //focusNode: index == 0 ? _focusNode : FocusNode(),
                                            );
                                          },
                                        ):ListView.builder(
                                          itemCount: 10,
                                          itemBuilder: (context,index){
                                            return HomeListTile(
                                              anime: snapshot.data![index],
                                              autofocus: autofocus,
                                            );
                                          },
                                        ),
                                      );
                                    }else if (snapshot.connectionState == ConnectionState.waiting){
                                      return Center(child: CircularProgressIndicator(color: data.tertiaryColor,),);
                                    }else{
                                      return Container(
                                        child: (data.preferrenceGroupValue == 1)?GridView.builder(
                                          itemCount: 10,
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              childAspectRatio: 1/1.6
                                          ),
                                          itemBuilder: (context,index){
                                            return DummyHomeTile(
                                              focusNode: index==0?_focusNode:FocusNode(),
                                              image: "imagesData[index]",
                                              autofocus: autofocus,
                                              //focusNode: index == 0 ? _focusNode : FocusNode(),
                                            );
                                          },
                                        ):ListView.builder(
                                          itemCount: 10,
                                          itemBuilder: (context,index){
                                            return DummyHomeListTile(
                                              image: "imagesData[index]",
                                              autofocus: autofocus,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  }
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

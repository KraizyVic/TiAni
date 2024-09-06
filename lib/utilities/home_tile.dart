import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/models/anime_model.dart';

import '../pages/details_page.dart';
class HomeTile extends StatefulWidget {
  final bool autofocus;
  final FocusNode? focusNode;
  final AnimeModel anime;
  final onDown;
  final onUp;
  const HomeTile({
    super.key,
    required this.autofocus,
    this.onDown,
    this.onUp,
    this.focusNode,
    required this.anime,
  });

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  FocusNode _homeTileNode = FocusNode();
  var tileBackground = Colors.transparent;
  var _width = 120.0;
  var _borderColor = Colors.transparent;
  @override
  void dispose() {
    // TODO: implement dispose
    _homeTileNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context,data,child) => Padding(
        padding: EdgeInsets.only(right: 10),
        child: Focus(
          focusNode: (widget.focusNode != null)?widget.focusNode:_homeTileNode,
          autofocus: widget.autofocus,
          onFocusChange: (hasFocus){
            setState(() {
              tileBackground =  hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.26):Colors.transparent;
              _width = (data.enablePreview == true)?hasFocus?300.0:120.0:120.0;
              _borderColor = hasFocus?data.tertiaryColor.withOpacity(.4):Colors.transparent;
              if(hasFocus){
                Scrollable.ensureVisible(
                  context,
                  alignment: 1, // Center the focused widget
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
                );
              }
            });
            //print("Focused");
          },
          onKeyEvent: (_homeTileNode,event){
            if(event is KeyDownEvent){
              if(event.logicalKey == LogicalKeyboardKey.enter){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(anime: widget.anime,)));
                //print("ThisHomeTilePressed");
                return KeyEventResult.handled;
              }else if(event.logicalKey == LogicalKeyboardKey.arrowDown && widget.onDown != null){
                widget.onDown();
                return KeyEventResult.handled;
              }else if(event.logicalKey == LogicalKeyboardKey.arrowUp && widget.onUp !=null){
                widget.onUp();
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: GestureDetector(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(anime: widget.anime,))),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: double.maxFinite,
              width: _width,
              decoration: BoxDecoration(
                color: tileBackground,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1,color: _borderColor)
              ),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //color: Theme.of(context).colorScheme.secondary.withOpacity(0.38),
                          color: Colors.blueGrey.withOpacity(.3),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Image.network(
                              widget.anime.image,
                              //anime.image,//"https://cdn.myanimelist.net/images/anime/1286/99889l.jpg?s=e497d08bef31ae412e314b90a54acfda",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.anime.titleEnglish,overflow: TextOverflow.ellipsis,),
                          Row(
                            children: [
                              Icon(Icons.star,size: 15,),
                              SizedBox(width: 5,),
                              Text(widget.anime.score.toString(),),
                              SizedBox(width: 5,),
                              Text(widget.anime.year.toString(),overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class HomeListTile extends StatefulWidget {
  final AnimeModel anime;
  final bool autofocus;
  const HomeListTile({
    super.key,
    required this.anime,
    required this.autofocus,
  });

  @override
  State<HomeListTile> createState() => _HomeListTileState();
}

class _HomeListTileState extends State<HomeListTile> {
  final FocusNode _focusNode = FocusNode();
  var tileBackground = Colors.transparent;
  var _width = 130.0;
  var _borderColor = Colors.transparent;
  var _sigma = 0.0;
  @override
  void initState() {
    // TODO: implement initState

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
    return Consumer<AppLogic>(
      builder:(context,data,child)=> Padding(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
        child: Focus(
          focusNode: _focusNode,
          autofocus: widget.autofocus,
          onFocusChange: (hasFocus){
            setState(() {
              tileBackground =  hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.2):Colors.transparent;
              //_width = _homeTileNode.hasFocus?300.0:130.0;
              _borderColor = (data.enableGlassMorphism == true)?hasFocus?data.tertiaryColor.withOpacity(.4):Colors.transparent:Colors.transparent;
              _sigma = (data.enableGlassMorphism == true)?hasFocus?10.0:0.0:0.0;
            });
            //print("Focused");
          },
          onKeyEvent: (_homeTileNode,event){
            if(event is KeyDownEvent){
              if(event.logicalKey == LogicalKeyboardKey.enter){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(anime: widget.anime,)));
                //print("ThisHomeTilePressed");
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _sigma,sigmaY: _sigma),
              child: GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(anime: widget.anime,)));},
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: 100,
                  width: _width,
                  decoration: BoxDecoration(
                    color: tileBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: _borderColor)
                  ),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.white38,
                          width: MediaQuery.of(context).size.width*0.17,
                          height: double.maxFinite,
                          child: Image.network(
                            widget.anime.image,
                            //anime.image,//"https://cdn.myanimelist.net/images/anime/1286/99889l.jpg?s=e497d08bef31ae412e314b90a54acfda",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.anime.titleEnglish,overflow: TextOverflow.ellipsis,),
                            Row(
                              children: [
                                Icon(Icons.star,size: 15,),
                                SizedBox(width: 5,),
                                Text(widget.anime.score.toString(),),
                                SizedBox(width: 9,),
                                Text("(${widget.anime.year.toString()})",style: TextStyle(color: Colors.grey),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


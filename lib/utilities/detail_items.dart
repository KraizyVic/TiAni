import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/models/anime_model.dart';
import 'package:tiani/models/review_model.dart';
import 'package:tiani/pages/review_page.dart';
import 'package:tiani/theme/theme.dart';

class SeasonTile extends StatefulWidget {

  final int seasonNumber;

  const SeasonTile({
    super.key,
    required this.seasonNumber,
  });

  @override
  State<SeasonTile> createState() => _SeasonTileState();
}

class _SeasonTileState extends State<SeasonTile> {
  final FocusNode _focusNode = FocusNode();
  Color focusColor = Colors.transparent;
  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
      child: Focus(
        focusNode: _focusNode,
        onFocusChange: (hasFocus){
          setState(() {
            focusColor = hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.2):Colors.transparent;
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: focusColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
            child: Text("Season ${widget.seasonNumber}"),
          ),
        ),
      ),
    );
  }
}

class EpisodeTile extends StatefulWidget {
  final int episodeNumber;
  const EpisodeTile({
    super.key,
    required this.episodeNumber,
  });

  @override
  State<EpisodeTile> createState() => _EpisodeTileState();
}

class _EpisodeTileState extends State<EpisodeTile> {
  FocusNode _focusNode = FocusNode();
  Color _focusColor = Colors.transparent;
  Color _borderColor = Colors.white;
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
        padding: const EdgeInsets.all(5.0),
        child: Focus(
          focusNode: _focusNode,
          onFocusChange: (hasFocus){
            setState(() {
              _focusColor = hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.5):Colors.transparent;
              _borderColor = hasFocus?data.tertiaryColor.withOpacity(0.7):Theme.of(context).colorScheme.secondary;
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _focusColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1.4,color: data.currentTheme==darkTheme?_focusNode.hasFocus?data.tertiaryColor:Theme.of(context).colorScheme.secondary:_focusNode.hasFocus?data.tertiaryColor:Theme.of(context).colorScheme.secondary)
            ),
            child: Text("${widget.episodeNumber}"),
          ),
        ),
      ),
    );
  }
}

class ReviewTile extends StatefulWidget {
  final ReviewModel review;
  final FocusNode? focusNode;
  final AnimeModel anime;
  final int index;
  final VoidCallback onEnter;
  const ReviewTile({
    super.key,
    required this.review,
    required this.anime,
    this.focusNode,
    required this.index,
    required this.onEnter,
  });

  @override
  State<ReviewTile> createState() => _ReviewTileState();
}
class _ReviewTileState extends State<ReviewTile> {
  final FocusNode _focusNode = FocusNode();
  Color _tileColor = Colors.transparent;
  late String date;
  @override
  void initState() {
    // TODO: implement initState
    DateTime parsed = DateTime.parse(widget.review.date);
    date = DateFormat('yyyy').format(parsed);

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
        padding: EdgeInsets.symmetric(horizontal: 20 /*MediaQuery.of(context).size.width*0.03*/,vertical: 8),
        child: Focus(
          focusNode: widget.focusNode ?? _focusNode,
          onFocusChange: (hasFocus){
            setState(() {
              _tileColor = hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.3):Colors.transparent;
            });
            if(hasFocus){
              Scrollable.ensureVisible(
                  context,
                alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 150)
              );
            }
          },
          onKeyEvent: (_focusNode,event){
            if(event.logicalKey == LogicalKeyboardKey.enter){
              widget.onEnter();
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.focusNode!.hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.4):Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  border: Border.all(width: 1.5,color: widget.focusNode!.hasFocus?data.tertiaryColor:Colors.transparent)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.38),
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage(widget.review.image),fit: BoxFit.cover)
                        ),
                        //child: Icon(Icons.person),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: 
                                    Row(
                                      children: [
                                        Text(
                                          widget.review.userName,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 20,),
                                        Expanded(child: Text(date,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)),))
                                      ],
                                    )
                                ),
                                Icon(Icons.star,color: data.tertiaryColor,size: 17,),
                                SizedBox(width: 5,),
                                Text(widget.review.score.toString()),
                                SizedBox(width: 20,),
                              ],
                            ),
                            Text(
                              widget.review.tag.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14,color: data.tertiaryColor.withOpacity(0.9)),
                            ),
                            //Text("Title",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20),),
                            Text(widget.review.review,maxLines: 2,overflow: TextOverflow.ellipsis,)
                          ],
                        ),
                      )
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



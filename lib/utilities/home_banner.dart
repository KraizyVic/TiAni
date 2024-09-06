import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/models/anime_model.dart';
import 'package:tiani/pages/details_page.dart';
class HomeBanner extends StatefulWidget {
  final VoidCallback changeFocus;
  final FocusNode? focusNode;
  final VoidCallback onKeyDown;
  final VoidCallback onKeyUp;
  final AnimeModel anime;
  const HomeBanner({
    super.key,
    this.focusNode,
    required this.changeFocus,
    required this.onKeyDown,
    required this.onKeyUp,
    required this.anime,
  });

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final FocusNode _bannerNode = FocusNode();
  var height = 300.0;
  var padding = 30.0;
  var bannerColor = Colors.black;
  var borderColor = Colors.transparent;
  @override
  void dispose() {
    // TODO: implement dispose
    _bannerNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child) => AnimatedPadding(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(right:/*(data.showAppBar==true)?padding:*/10,),
        child: Focus(
          focusNode: (widget.focusNode == null)?_bannerNode:widget.focusNode,
          autofocus: true,
          onFocusChange: (hasFocus){
            setState(() {
              widget.changeFocus();
              bannerColor = hasFocus?Theme.of(context).canvasColor.withOpacity(0.8):Theme.of(context).canvasColor;
              //height = _bannerNode.hasFocus?MediaQuery.of(context).size.height*0.6 : 300.0;
              borderColor = hasFocus?data.tertiaryColor:Colors.transparent;
              padding = hasFocus?10.0:30.0;
              if(hasFocus){
                Scrollable.ensureVisible(
                  context,
                  alignment: 0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
                );
              }
            });
          },
          onKeyEvent: (_bannerNode,event){
            if(event is KeyDownEvent){
              if(event.logicalKey == LogicalKeyboardKey.enter){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(anime: widget.anime,)));
                return KeyEventResult.handled;
              }else if(event.logicalKey == LogicalKeyboardKey.arrowDown /*|| event.logicalKey == LogicalKeyboardKey.arrowRight*/){
                widget.onKeyDown();
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular((data.showAppBar == false)?0.0:20.0),//BorderRadius.only(topLeft: Radius.circular((data.showAppBarinHomePage == false)?0.0:20.0 ),topRight: Radius.circular((data.showAppBarinHomePage == false)?0.0:20.0),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                //border: Border.all(width: 0,color: borderColor),
                borderRadius: BorderRadius.circular((data.showAppBar == false)?0.0:20),//BorderRadius.only(topLeft: Radius.circular((data.showAppBarinHomePage == false)?0.0:20.0),topRight: Radius.circular((data.showAppBarinHomePage == false)?0.0:20.0),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                color: Colors.blueGrey.withOpacity(0.3),//Theme.of(context).colorScheme.secondary.withOpacity(0.68)
              ),
              curve: Curves.ease,
              width: data.showAppBar==true? MediaQuery.of(context).size.width*0.955:_bannerNode.hasFocus?MediaQuery.of(context).size.width*0.955:MediaQuery.of(context).size.width*0.955,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular((data.showAppBar == false)?0.0:20),//BorderRadius.only(topLeft: Radius.circular((data.showAppBarinHomePage == false)?0.0:20.0),topRight: Radius.circular((data.showAppBarinHomePage == false)?0.0:20.0),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                      child: Image.network(
                        widget.anime.trailerImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(anime: widget.anime,)));},
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [(widget.focusNode == null)?_bannerNode.hasFocus?Theme.of(context).canvasColor.withOpacity(0.5):Theme.of(context).canvasColor:widget.focusNode!.hasFocus?Theme.of(context).canvasColor.withOpacity(0.5):Theme.of(context).canvasColor,Colors.transparent],
                          ),
                        borderRadius: BorderRadius.circular((data.showAppBar == false)?0.0:20),//BorderRadius.only(topLeft: Radius.circular((data.showAppBarinHomePage == false)?0.0:20.0),topRight: Radius.circular((data.showAppBarinHomePage == false)?0.0:20.0),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(widget.anime.type,),
                            SizedBox(width: 20,),
                            Text(widget.anime.year.toString(),),
                            SizedBox(width: 20,),
                            Text(widget.anime.duration,),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(
                          widget.anime.titleEnglish,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

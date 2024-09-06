import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../functionality/app_logic.dart';

class DummyHomeTile extends StatefulWidget {
  final String image;
  final bool autofocus;
  final FocusNode? focusNode;
  final onDown;
  final onUp;
  const DummyHomeTile({
    super.key,
    required this.image,
    required this.autofocus,
    this.onDown,
    this.onUp,
    this.focusNode,
  });

  @override
  State<DummyHomeTile> createState() => _DummyHomeTileState();
}

class _DummyHomeTileState extends State<DummyHomeTile> {
  late Color tileBackground = Colors.blueGrey.withOpacity(0.7);
  var _width = 120.0;
  var _borderColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context,data,child) => Padding(
        padding: EdgeInsets.only(right: 10),
        child: Focus(
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          onFocusChange: (hasFocus){
            setState(() {
              tileBackground =  hasFocus?Colors.blueGrey:Colors.blueGrey.withOpacity(0.7);
              //_width = (data.enablePreview == true)?hasFocus?300.0:120.0:120.0;
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
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage()));
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
            //onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage())),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: double.maxFinite,
              width: _width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                //border: Border.all(width: 1,color: _borderColor)
              ),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: tileBackground,//color: Theme.of(context).colorScheme.secondary.withOpacity(0.38),
                          child: SizedBox(
                            width: double.maxFinite,
                            /*child: Image.asset(
                              widget.image,
                              //anime.image,//"https://cdn.myanimelist.net/images/anime/1286/99889l.jpg?s=e497d08bef31ae412e314b90a54acfda",
                              fit: BoxFit.cover,
                            ),*/
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2,bottom: 2,right: 40),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: tileBackground,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2,bottom: 2,right: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: tileBackground,
                                ),
                              ),
                            ),
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


class DummyHomeBanner extends StatefulWidget {
  final VoidCallback changeFocus;
  final FocusNode? focusNode;
  final VoidCallback onKeyDown;
  final VoidCallback onKeyUp;
  const DummyHomeBanner({
    super.key,
    this.focusNode,
    required this.changeFocus,
    required this.onKeyDown,
    required this.onKeyUp,
  });

  @override
  State<DummyHomeBanner> createState() => _DummyHomeBannerState();
}

class _DummyHomeBannerState extends State<DummyHomeBanner> {
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
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage()));
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
                  color: Colors.blueGrey.withOpacity(0.68)
              ),
              curve: Curves.ease,
              width: data.showAppBar==true? MediaQuery.of(context).size.width*0.93:_bannerNode.hasFocus?MediaQuery.of(context).size.width*0.93:MediaQuery.of(context).size.width*0.93,

              child: Stack(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular((data.showAppBar == false)?0.0:20),//BorderRadius.only(topLeft: Radius.circular((data.showAppBarinHomePage == false)?0.0:20.0),topRight: Radius.circular((data.showAppBarinHomePage == false)?0.0:20.0),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                      /*child: Image.asset(
                        "lib/assets/545909.jpg",
                        fit: BoxFit.cover,
                      ),*/
                    ),
                  ),
                  GestureDetector(
                    //onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage()));},
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
                        Container(
                          height: 20,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,//data.tertiaryColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 20,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,//data.tertiaryColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)
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

class DummyHomeListTile extends StatefulWidget {
  final String image;
  final bool autofocus;
  const DummyHomeListTile({
    super.key,
    required this.image,
    required this.autofocus,
  });

  @override
  State<DummyHomeListTile> createState() => _DummyHomeListTileState();
}

class _DummyHomeListTileState extends State<DummyHomeListTile> {
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
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage()));
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
                //onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage()));},
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
                          /*child: Image.asset(
                            widget.image,
                            //anime.image,//"https://cdn.myanimelist.net/images/anime/1286/99889l.jpg?s=e497d08bef31ae412e314b90a54acfda",
                            fit: BoxFit.cover,
                          ),*/
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Gojo Sensei",overflow: TextOverflow.ellipsis,),
                            Row(
                              children: [
                                Icon(Icons.star,size: 15,),
                                SizedBox(width: 5,),
                                Text("9.0",),
                                SizedBox(width: 9,),
                                Text("(2024)",style: TextStyle(color: Colors.grey),)
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

class DummyCharacterTile extends StatefulWidget {
  final bool autofocus;
  const DummyCharacterTile({super.key,required this.autofocus});

  @override
  State<DummyCharacterTile> createState() => _DummyCharacterTileState();
}

class _DummyCharacterTileState extends State<DummyCharacterTile> {
  final FocusNode _focusNode = FocusNode();

  var borderColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Focus(
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        onFocusChange: (hasFocus){
          setState(() {
            borderColor = hasFocus?Provider.of<AppLogic>(context,listen: false).tertiaryColor:Colors.transparent;
          });
          if(hasFocus){
            Scrollable.ensureVisible(
              context,
              alignment: 1,
              alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    /*image: DecorationImage(
                    image: AssetImage("imagesData[4]"),
                    fit: BoxFit.cover
                  ),*/
                    color: Colors.white38,
                    border: Border.all(width: 1.5,color:borderColor)
                ),
                child: Icon(Icons.person,),
              ),
            ),
            Text("Blyatt")
          ],
        ),
      ),
    );
  }
}

class DummyReviewTile extends StatefulWidget {
  const DummyReviewTile({super.key});

  @override
  State<DummyReviewTile> createState() => _DummyReviewTileState();
}
class _DummyReviewTileState extends State<DummyReviewTile> {
  final FocusNode _focusNode = FocusNode();
  Color _tileColor = Colors.transparent;
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
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03,vertical: 8),
        child: Focus(
          focusNode: _focusNode,
          onFocusChange: (hasFocus){
            setState(() {
              _tileColor = hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.3):Colors.transparent;
            });
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
                    color: _focusNode.hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.4):Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    border: Border.all(width: 1.5,color: _focusNode.hasFocus?data.tertiaryColor:Colors.transparent)
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
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.person),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 90,top: 15),
                              child: Container(
                                height: 15,
                                decoration: BoxDecoration(
                                  color: data.tertiaryColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 50,top: 10),
                              child: Container(
                                height: 15,
                                decoration: BoxDecoration(
                                  color: data.tertiaryColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20,top: 10),
                              child: Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: data.tertiaryColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10)
                                ),
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
        ),
      ),
    );
  }
}





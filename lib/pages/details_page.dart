import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/models/anime_model.dart';
import 'package:tiani/pages/details.dart';
import 'package:tiani/pages/trailer_page.dart';
import 'package:tiani/utilities/mods.dart';
import 'package:tiani/pages/account_page.dart';
import 'package:tiani/pages/search_page.dart';
import 'package:tiani/pages/settings_page.dart';
import 'package:tiani/utilities/details_button.dart';

class DetailsPage extends StatefulWidget {
  final AnimeModel anime;
  const DetailsPage({super.key,required this.anime});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  double opacityR = 0.2;
  FocusNode _focusNode = FocusNode();
  late Widget detail ;
  late AnimationController _controller ;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    detail = Intro(anime: widget.anime);
    /*_controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Duration of the animation
    );

    _animation = Tween<Alignment>(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    // Add a listener to reverse the animation when it completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });*/
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }

  double position = 1;
  double width = 0;
  double opacity = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child)=> Scaffold(
        //backgroundColor: Colors.white30,
        body: Stack(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Image.network(
                widget.anime.trailerImage,//"lib/assets/nyx_havoc_by_shado2art_dg1pk8i.png",
                fit: BoxFit.cover,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Theme.of(context).canvasColor.withOpacity(0.9),Theme.of(context).canvasColor.withOpacity(opacityR)])
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Theme.of(context).canvasColor.withOpacity(0.5),Colors.transparent],begin: Alignment.topCenter,end: Alignment.center)
              ),
            ),
            Align(
              alignment: AlignmentDirectional(position, -0.8),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10,sigmaY: 30),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 550),
                    curve: Curves.easeInOut,
                    color: data.tertiaryColor.withOpacity(opacity),
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(data.accounnts[data.currentAccount].movieList.contains(widget.anime) || data.accounnts[data.currentAccount].tvList.contains(widget.anime) || data.accounnts[data.currentAccount].uncategorisedList.contains(widget.anime)?"Anime added Successfully :)":"Anime removed successfully :(",overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                ModedAppBar(
                  action1: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage())), icon: HugeIcons.strokeRoundedSearch01),
                  action2: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>AccountPage())), icon: HugeIcons.strokeRoundedUserCircle),
                  action3: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingsPage())), icon: HugeIcons.strokeRoundedSettings03),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailsButton(
                                  buttonTxt: "Play from start",
                                  buttonIcon: Icons.play_arrow,
                                  autofocus: true,
                                  enter: (){
                                    setState(() {
                                      opacityR = 0.2;
                                    });
                                  },
                                  onbutton: (){},
                                ),
                                DetailsButton(
                                  buttonTxt: "Watch trailer",
                                  buttonIcon: Icons.movie,
                                  autofocus: false,
                                  enter: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TrailerPage(anime: widget.anime)));
                                  },
                                  onbutton: (){},
                                ),
                                DetailsButton(
                                  buttonTxt: "Episodes",
                                  buttonIcon: Icons.folder,
                                  autofocus: false,
                                  enter: (){
                                    setState(() {
                                      detail = Seasons(anime: widget.anime,);
                                      opacityR = 0.4;
                                    });
                                  },
                                  onbutton: (){},
                                ),
                                DetailsButton(
                                  buttonTxt: "Overview",
                                  buttonIcon: Icons.question_mark,
                                  autofocus: false,
                                  enter: (){
                                    setState(() {
                                      detail = Overview(anime: widget.anime,);
                                      opacityR = 0.2;
                                    });
                                  },
                                  onbutton: (){},
                                ),
                                DetailsButton(
                                  buttonTxt: "Rate",
                                  buttonIcon: Icons.star,
                                  autofocus: false,
                                  enter: (){
                                    setState(() {
                                      detail = Rate();
                                      opacityR = 0.2;
                                    });
                                  },
                                  onbutton: (){},
                                ),
                                DetailsButton(
                                  buttonTxt: "Reviews",
                                  buttonIcon: Icons.reviews,
                                  autofocus: false,
                                  enter: (){
                                    setState(() {
                                      detail = Reviews(reviewNode: _focusNode,anime: widget.anime,);
                                      opacityR = 0.2;
                                    });
                                  },
                                  onbutton: (){},
                                ),
                                DetailsButton(
                                  buttonTxt: data.accounnts[data.currentAccount].movieList.contains(widget.anime) || data.accounnts[data.currentAccount].tvList.contains(widget.anime) || data.accounnts[data.currentAccount].uncategorisedList.contains(widget.anime)?"Remove from list":"Add to list" ,//"Add to List",
                                  buttonIcon: data.accounnts[data.currentAccount].movieList.contains(widget.anime) || data.accounnts[data.currentAccount].tvList.contains(widget.anime) || data.accounnts[data.currentAccount].uncategorisedList.contains(widget.anime)?Icons.delete_forever:Icons.bookmark,
                                  autofocus: false,
                                  onbutton: (){
                                    setState(() {
                                      width = 0;
                                    });
                                  },
                                  enter: (){
                                    setState(() {
                                      opacityR = 0.2;
                                      data.accounnts[data.currentAccount].movieList.contains(widget.anime) || data.accounnts[data.currentAccount].tvList.contains(widget.anime) || data.accounnts[data.currentAccount].uncategorisedList.contains(widget.anime)?data.removeFromList(widget.anime):data.addAnimeToList(widget.anime);
                                      width = 250.0;
                                      opacity = 0.4;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: MediaQuery.of(context).size.height*0.6,
                        color: data.tertiaryColor,
                      ),
                      Expanded(
                        child: detail,
                      )
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

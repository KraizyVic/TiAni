import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/models/anime_model.dart';
import 'package:tiani/pages/details.dart';
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
  late Widget detail ;
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    detail = Intro(anime: widget.anime);
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
                                ),
                                DetailsButton(
                                  buttonTxt: "Watch trailer",
                                  buttonIcon: Icons.movie,
                                  autofocus: false,
                                  enter: (){
                                    setState(() {
                                      opacityR = 0.2;
                                    });
                                  },
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
                                ),
                                DetailsButton(
                                  buttonTxt: "Add to List",
                                  buttonIcon: Icons.bookmark,
                                  autofocus: false,
                                  enter: (){
                                    setState(() {
                                      opacityR = 0.2;
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

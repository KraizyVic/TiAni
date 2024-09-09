import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/pages/account_page.dart';
import 'package:tiani/pages/search_page.dart';
import 'package:tiani/pages/serrie_page.dart';
import 'package:tiani/pages/settings_page.dart';
import 'package:tiani/pages/watch_list.dart';

import '../utilities/mods.dart';
import 'home_page.dart';
import 'movie_page.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [
    HomePage(),
    MoviePage(),
    SerriePage(),
    WatchList()
  ];

  Widget currentPage = HomePage();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child) => Scaffold(
        body: Stack(
          children: [
            data.backgroundPicInMainPage?
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(data.currentPic),
                    fit: BoxFit.cover,
                  )
              ),
            ):Container(color: Theme.of(context).canvasColor,),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).canvasColor,Theme.of(context).canvasColor.withOpacity(0.0)],
                  begin: Alignment.bottomCenter,end: Alignment.topCenter,
                )
              ),
            ),
            /*BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
              child: Container(
                color: (data.backgroundPicInMainPage == true)?Theme.of(context).canvasColor.withOpacity(0.5):Theme.of(context).canvasColor,
              ),
            ),*/
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor.withOpacity(0.2),
                              border: Border(right: BorderSide(width: 1,color: data.tertiaryColor.withOpacity(0.5)))
                            ),
                            width: MediaQuery.of(context).size.width*0.045,
                            child: Padding(
                              padding: const EdgeInsets.all(.0),
                              child: Column(
                                children: [
                                  (data.showAppBar == true)?SizedBox(width: 0,):ModedIconButton(onPressed: ()=>setState(() {}), icon: Icons.snowboarding),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        (data.showAppBar == false)?ModedIconButton(
                                          onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage())),
                                          icon: Icons.search,
                                        ):SizedBox(),
                                        ModedIconButton(
                                            onPressed: (){
                                              setState(() {
                                                currentPage = HomePage();
                                              });
                                            },
                                            icon: Icons.home_outlined,
                                        ),
                                        SizedBox(height: 10,),
                                        ModedIconButton(
                                            onPressed: (){
                                              setState(() {
                                                currentPage = MoviePage();
                                              });
                                            },
                                            icon: Icons.play_circle_outline,
                                        ),
                                        SizedBox(height: 10,),
                                        ModedIconButton(
                                            //onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SerriePage())),
                                            onPressed: (){
                                              setState(() {
                                                currentPage = SerriePage();
                                              });
                                            },
                                            icon: Icons.folder_open_outlined
                                        ),
                                        SizedBox(height: 10,),
                                        ModedIconButton(
                                            onPressed: (){
                                              setState(() {
                                                currentPage = WatchList();
                                              });
                                            },
                                            icon: Icons.bookmark_border_sharp,
                                        )
                                      ],
                                    ),
                                  ),
                                  (data.showAppBar == false)?ModedIconButton(
                                    onPressed: (){
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (context)=>const MoreActions(),
                                        );
                                      });
                                    },
                                    icon: Icons.dehaze
                                  ):const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          children: [
                            (data.showAppBar == true)?ModedAppBar(
                              leading: SizedBox(),//(data.showAppBar = true)?Icon(Icons.snowboarding)/*ModedIconButton(onPressed: ()=>setState(() {}), icon: Icons.snowboarding)*/:Text(""),
                              //leading: Center(child: Container(width:200,color:Colors.red,child: Text("Uanimurs",style: TextStyle(fontSize: 20,color: data.tertiaryColor),))),
                              action1: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage())), icon: HugeIcons.strokeRoundedSearch01),
                              action2: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>AccountPage())), icon: HugeIcons.strokeRoundedUserCircle),
                              action3: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingsPage())), icon: HugeIcons.strokeRoundedSettings03),
                            ):SizedBox(height: 0,),
                            Expanded(child: currentPage)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class MoreActions extends StatefulWidget {
  const MoreActions({super.key});

  @override
  State<MoreActions> createState() => _MoreActionsState();
}

class _MoreActionsState extends State<MoreActions> {
  FocusNode _accountNode = FocusNode();
  FocusNode _settingNode = FocusNode();
  var accountColor = Colors.transparent;
  var settingColor = Colors.transparent;
  @override
  void dispose() {
    // TODO: implement dispose
    _accountNode.dispose();
    _settingNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child)=> AnimatedContainer(
        duration: Duration(milliseconds: 300),
        color: Theme.of(context).canvasColor.withOpacity(0.9),
        child: AlertDialog(
          //title: Text("Choose Action"),
          backgroundColor: Colors.transparent,
          content: Container(
            //height: MediaQuery.of(context).size.height*0.2,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Focus(
                  focusNode: _accountNode,
                  autofocus: true,
                  onFocusChange: (hasFocus){
                    setState(() {
                      accountColor = hasFocus?Colors.blue:Colors.transparent;
                    });
                  },
                  onKeyEvent: (_accountNode,event){
                    if(event is KeyDownEvent){
                      if(event.logicalKey == LogicalKeyboardKey.enter){
                        Feedback.forTap(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AccountPage()));
                        return KeyEventResult.handled;
                      }
                    }
                    return KeyEventResult.ignored;
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: MediaQuery.of(context).size.height*0.25,
                    width: MediaQuery.of(context).size.height*0.25,
                    decoration: BoxDecoration(
                      //color: accountColor,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.2,
                          width: MediaQuery.of(context).size.height*0.2,
                          decoration:BoxDecoration(
                            //color: Colors.brown,
                            shape: BoxShape.circle
                          ),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: _accountNode.hasFocus?data.tertiaryColor:Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                          ),
                        ),
                        Text("Account",style: TextStyle(color: _accountNode.hasFocus?data.tertiaryColor:Theme.of(context).colorScheme.secondary.withOpacity(0.7)),)
                      ],
                    ),
                  ),
                ),
                Focus(
                  focusNode: _settingNode,
                  autofocus: false,
                  onFocusChange: (hasFocus){
                    setState(() {
                      settingColor = hasFocus?Colors.green:Colors.transparent;
                    });
                  },
                  onKeyEvent: (_settingNode,event){
                    if(event is KeyDownEvent){
                      if(event.logicalKey == LogicalKeyboardKey.enter){
                        Feedback.forTap(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                        return KeyEventResult.handled;
                      }
                    }
                    return KeyEventResult.ignored;
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: MediaQuery.of(context).size.height*0.25,
                    width: MediaQuery.of(context).size.height*0.25,
                    decoration: BoxDecoration(
                      //color: settingColor,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.2,
                          width: MediaQuery.of(context).size.height*0.2,
                          decoration:BoxDecoration(
                              //color: Colors.brown,
                              shape: BoxShape.circle
                          ),
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedSettings03,
                            color: _settingNode.hasFocus?Provider.of<AppLogic>(context,listen: false).tertiaryColor:Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                            size: 40,
                          ),
                        ),
                        Text("Settings",style: TextStyle(color: _settingNode.hasFocus?data.tertiaryColor:Theme.of(context).colorScheme.secondary.withOpacity(0.7)),)
                      ],
                    ),
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}


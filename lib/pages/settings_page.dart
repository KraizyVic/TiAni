import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/pages/account_page.dart';
import 'package:tiani/pages/search_page.dart';
import 'package:tiani/pages/setting.dart';
import 'package:tiani/utilities/settings_tiles.dart';

import '../utilities/mods.dart';
import 'main_page.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Widget> settings = [
    Appearance(),
    Preference(),
    Terms(),
    About(),
    Contact(),
  ];
  var settingindex = 0;

  void changeSettings(int buttonIndex){
    setState(() {
      settingindex = buttonIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child)=> Scaffold(
        //backgroundColor: Colors.orange,
        body: Stack(
          children: [
            AnimatedContainer(
              height: double.maxFinite,
              width: double.maxFinite,
              duration: Duration(milliseconds: 600),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(data.currentPic),
                  fit: BoxFit.cover
                )
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Theme.of(context).colorScheme.primaryContainer,Theme.of(context).canvasColor.withOpacity(0.2)])
              ),
            ),
            Column(
              children: [
                ModedAppBar(
                  action1: ModedIconButton(onPressed: ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MainPage())), icon: HugeIcons.strokeRoundedHome09),
                  action2: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage())), icon: HugeIcons.strokeRoundedSearch01),
                  action3: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>AccountPage())), icon: HugeIcons.strokeRoundedUserCircle),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          //color: Colors.blue.withOpacity(0.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SettingsTiles(buttonName: "Appearance", autofocus: true,onEnter: ()=>changeSettings(0),action: Icon(Icons.chevron_right,size: 20,),),
                              SettingsTiles(buttonName: "Preference", autofocus: false, onEnter: ()=>changeSettings(1),action: Icon(Icons.chevron_right,size: 20,),),
                              SettingsTiles(buttonName: "Terms",autofocus: false,onEnter: ()=>changeSettings(2),action: Icon(Icons.chevron_right,size: 20,),),
                              SettingsTiles(buttonName: "About",autofocus: false,onEnter: ()=>changeSettings(3),action: Icon(Icons.chevron_right,size: 20,),),
                              SettingsTiles(buttonName: "Contacts",autofocus: false,onEnter: ()=>changeSettings(4),action: Icon(Icons.chevron_right,size: 20,),),
                            ],
                          ),
                        )
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        color: data.tertiaryColor,
                        width: 1,
                        height: MediaQuery.of(context).size.height*0.6,
                      ),
                      Expanded(
                        child: Container(
                          //color: Colors.green.withOpacity(0.5),
                          child: settings[settingindex],
                        ),
                      ),
                    ],
                  )
                )
              ]
            )
          ],
        ),
      ),
    );
  }
}

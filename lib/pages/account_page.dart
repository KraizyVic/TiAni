import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/utilities/mods.dart';
import 'package:tiani/pages/search_page.dart';
import 'package:tiani/pages/settings_page.dart';

import '../utilities/account_items.dart';
import 'main_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context,data,child)=> Scaffold(
        //backgroundColor: Colors.pink,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Image.asset(
              data.currentPic,
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,

            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Theme.of(context).canvasColor.withOpacity(0.8),Theme.of(context).canvasColor.withOpacity(0.4)],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                )
              ),
            ),
            Column(
              children: [
                ModedAppBar(
                  action1: ModedIconButton(onPressed: ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MainPage())), icon:HugeIcons.strokeRoundedHome09,),
                  action2: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage())), icon: HugeIcons.strokeRoundedSearch01),
                  action3: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingsPage())), icon: HugeIcons.strokeRoundedSettings03,),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          //color: Colors.red,
                          height: MediaQuery.of(context).size.height*0.55,
                          margin: EdgeInsets.symmetric(horizontal: 40,),
                          child: CurrentAccountTile(
                            account: data.accounnts[data.currentAccount],
                          ),
                        ),
                      ),
                      Container(
                        color: data.tertiaryColor,
                        width: 1,
                        height: MediaQuery.of(context).size.height*0.6,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Select Account",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: data.accounnts.length,
                                        itemBuilder: (context,index){
                                          return AccountAvatar(
                                            name: data.accounnts[index].name,
                                            profileImage: data.accounnts[index].pfpImage,
                                            autofocus: index == 0,
                                            onEnter:()=> data.displayAccount(index),
                                            index: index,
                                          );
                                        },
                                      )
                                    ),
                                  ],
                                ),
                              ),
                              AddAccountButton(
                                color: data.tertiaryColor,
                                onEnter: ()=> data.addAccount(context),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

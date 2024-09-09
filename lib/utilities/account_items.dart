import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/models/app_models.dart';
import 'package:tiani/utilities/character_tile.dart';

import 'mods.dart';


// CURRENT ACCOUNT TILE :

class CurrentAccountTile extends StatelessWidget {
  final AccountModel account;
  const CurrentAccountTile({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context,data,child) => ClipRRect(
        borderRadius:BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1.3,color:data.tertiaryColor.withOpacity(0.2)),
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                    ]
                )
            ),
            //height: MediaQuery.of(context).size.height*0.5,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Current Account",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Container(
                          height: 150,
                          width: 150,
                          color: Colors.white38,
                          /*child: Image.asset(
                            account.pfpImage,
                            fit: BoxFit.cover,
                          ),*/
                          child: Icon(Icons.person,size: 50,),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: ${account.name}"),
                              SizedBox(height: 10,),
                              Text("Type: Local account")
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ModedIconButton(
                              onPressed: (){},
                              icon: Icons.edit,
                            ),
                            ModedIconButton(
                              onPressed: ()=>data.deleteAccount(),
                              icon: Icons.delete,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Watched films :\n${account.watchedFilms}",textAlign: TextAlign.center,),
                      Text("Movie list :\n${account.movieList.length}",textAlign: TextAlign.center,),
                      Text("TV list :\n${account.tvList.length}",textAlign: TextAlign.center,),
                      Text("Uncategorised list :\n${account.uncategorisedList.length}",textAlign: TextAlign.center,),
                    ],
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

// SELECT ACCOUNT TILE

class AccountAvatar extends StatefulWidget {
  final String name;
  final String profileImage;
  final bool autofocus;
  final int index;
  final VoidCallback onEnter;
  const AccountAvatar({
    super.key,
    required this.name,
    required this.profileImage,
    required this.autofocus,
    required this.onEnter,
    required this.index,
  });

  @override
  State<AccountAvatar> createState() => _AccountAvatarState();
}

class _AccountAvatarState extends State<AccountAvatar> {
  FocusNode _avatarNode = FocusNode();
  var containerColor = Colors.transparent;
  var sigma = 0.0;

  @override
  void dispose() {
    _avatarNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child)=> Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: sigma,sigmaY: sigma),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: containerColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Focus(
                        focusNode: _avatarNode,
                        autofocus: widget.autofocus,
                        descendantsAreFocusable: true,
                        onFocusChange: (hasFocus){
                          setState(() {
                            containerColor = hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.2):Colors.transparent;
                            sigma = (data.enableGlassMorphism == true)?hasFocus?10.0:0.0:0.0;
                          });
                        },
                        onKeyEvent: (_avatarNode,event){
                          if(event is KeyDownEvent){
                            if(event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.select){
                              widget.onEnter();
                              return KeyEventResult.handled;
                            }
                          }
                          return KeyEventResult.ignored;
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            //color: containerColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white38,
                                    shape: BoxShape.circle
                                  ),
                                  width: 50,
                                  height: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      /*image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          widget.profileImage,
                                        ),
                                      )*/
                                    ),
                                    child: Icon(Icons.person),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(widget.name),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ModedIconButton(
                      onPressed:()=> data.deleteListedAccount(widget.index),
                      icon: Icons.delete,
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


// ADD ACCOUNT BUTTON

class AddAccountButton extends StatefulWidget {
  final Color color;
  final VoidCallback onEnter;
  const AddAccountButton({
    super.key,
    required this.color,
    required this.onEnter,
  });

  @override
  State<AddAccountButton> createState() => _AddAccountButtonState();
}
class _AddAccountButtonState extends State<AddAccountButton> {
  FocusNode _iconButtonNode = FocusNode();
  var _sigma = 0.0;
  var _color = Colors.transparent;
  var _borderColor = Colors.transparent;
  @override
  void dispose() {
    // TODO: implement dispose
    _iconButtonNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 7),
      child: Focus(
        focusNode: _iconButtonNode,
        descendantsAreFocusable: true,
        autofocus: false,
        onFocusChange: (change){
          setState(() {
            _sigma = _iconButtonNode.hasFocus?5.0:0;
            _color = _iconButtonNode.hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.2):Colors.transparent;
            _borderColor = _iconButtonNode.hasFocus?widget.color.withOpacity(0.4):Colors.transparent;
          });
        },
        onKeyEvent: (iconButtonNode,event){
          if(event is KeyDownEvent){
            if (event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.select){
              print("Add account pressed");
              widget.onEnter();
            }
          }
          return KeyEventResult.ignored;
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _sigma,sigmaY: _sigma),
            child: AnimatedContainer(
              width: 200,
              duration: Duration(milliseconds: 250),
              decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5,color: _borderColor)
              ),
              //width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.plus,
                      size: 30,
                    ),
                    SizedBox(width: 10,),
                    Text("Add Account"),
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

class AccountDialog extends StatefulWidget {
  const AccountDialog({super.key});

  @override
  State<AccountDialog> createState() => _AccountDialogState();
}

class _AccountDialogState extends State<AccountDialog> {
  var autofocus = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: Text("Add"),
      backgroundColor: Colors.transparent,
      content: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
          child: Container(
            width: MediaQuery.of(context).size.width*0.6,
            height: MediaQuery.of(context).size.height*0.6,
            decoration: BoxDecoration(
              border: Border.all(width: 1.5,color: Provider.of<AppLogic>(context,listen: false).tertiaryColor),
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2)
            ),
            //color: Colors.pink,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "ADD ACCOUNT",
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                        )
                      )
                    ),
                    ModedIconButton(onPressed: ()=>Navigator.pop(context), icon: Icons.clear)
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              onSubmitted: (action){
                                setState(() {
                                  autofocus = true;
                                });
                              },
                              autofocus: true,
                              //textCapitalization: TextCapitalization.characters,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context).canvasColor.withOpacity(0.7),
                                hintText: "Account Name",
                                suffixIcon: Icon(Icons.add,color: Provider.of<AppLogic>(context,listen: false).tertiaryColor,),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1,color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1,color: Provider.of<AppLogic>(context,listen: false).tertiaryColor,),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text("Choose PFP",style: TextStyle(fontSize: 18),),
                            ),
                            Expanded(
                              child: GridView.builder(
                                itemCount: 10,
                                //scrollDirection: Axis.horizontal,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4
                                ),
                                itemBuilder: (context,index){
                                  return PfpTile(
                                    autofocus: autofocus,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AddAccountButton(
                    color: Provider.of<AppLogic>(context,listen: false).tertiaryColor ,
                    onEnter: (){},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




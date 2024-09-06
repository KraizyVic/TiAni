import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/functionality/data.dart';
import 'package:tiani/models/character_model.dart';

class CharacterTile extends StatefulWidget {
  final CharacterModel character;
  final bool autofocus;
  const CharacterTile({
    super.key,
    required this.autofocus,
    required this.character
  });

  @override
  State<CharacterTile> createState() => _CharacterTileState();
}

class _CharacterTileState extends State<CharacterTile> {
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
                  image: DecorationImage(
                    image:  NetworkImage(widget.character.image),
                    fit: BoxFit.cover
                  ),
                  //color: Colors.white38,
                  border: Border.all(width: 1.5,color:borderColor)
                ),
                //child: Icon(Icons.person,),
              ),
            ),
            Text(widget.character.name,maxLines: 1,overflow: TextOverflow.ellipsis,)
          ],
        ),
      ),
    );
  }
}

class PfpTile extends StatefulWidget {
  final bool autofocus;
  const PfpTile({
    super.key,
    required this.autofocus,
  });

  @override
  State<PfpTile> createState() => _PfpTileState();
}

class _PfpTileState extends State<PfpTile> {
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
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 100,
          width: 100,
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
    );
  }
}


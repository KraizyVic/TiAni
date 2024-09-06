import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
class ColorTile extends StatefulWidget {
  final Color? color;
  final String? imagePath;
  const ColorTile({
    super.key,
    this.color,
    this.imagePath,
  });

  @override
  State<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
  FocusNode _focusNode = FocusNode();
  var fcolor = Colors.transparent;
  var borderColor = Colors.transparent;
  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context,data,child)=> Padding(
        padding: const EdgeInsets.all(8.0),
        child: Focus(
          focusNode: _focusNode,
          onFocusChange: (hasFocus){
            setState(() {
              fcolor = _focusNode.hasFocus?Colors.black26:Colors.transparent;
              borderColor = _focusNode.hasFocus?data.tertiaryColor:Colors.transparent;
            });
          },
          onKeyEvent: (_focusNode,event){
            if(event is KeyEvent){
              if(event.logicalKey == LogicalKeyboardKey.enter){
                //print("Color clicked");
                data.changeColor(widget.color!);
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  decoration:BoxDecoration(
                    color: widget.color,
                    border: Border.all(width: 2,color: borderColor),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Container(
                  color: fcolor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class BackgroundImage extends StatefulWidget {
  final String image;
  const BackgroundImage({
    super.key,
    required this.image
  });

  @override
  State<BackgroundImage> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  FocusNode _imagefocusNode = FocusNode();
  var focusColor = Colors.transparent;
  var _borderColor = Colors.transparent;
  @override
  void dispose() {
    // TODO: implement dispose
    _imagefocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context,data,child)=> Focus(
        focusNode: _imagefocusNode,
        onFocusChange: (hasFocus){
          setState(() {
            focusColor = _imagefocusNode.hasFocus?Colors.white12:Colors.transparent;
            _borderColor = _imagefocusNode.hasFocus?data.tertiaryColor:Colors.transparent;
          });
        },
        onKeyEvent: (_imagefocusNode,event){
          if(event.logicalKey == LogicalKeyboardKey.enter){
            //print("Image Clicked");
            data.changePic(widget.image);
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                border: Border.all(width: 1.5,color: _borderColor),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: ClipRRect(borderRadius:BorderRadius.circular(10),child: Image.asset(widget.image,fit: BoxFit.cover,)),
                  ),
                  Container(
                    color: focusColor,
                    width: double.maxFinite,
                    height: double.maxFinite,
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


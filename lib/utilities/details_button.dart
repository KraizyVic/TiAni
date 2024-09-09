import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
class DetailsButton extends StatefulWidget {
  final String buttonTxt;
  final bool autofocus;
  final IconData buttonIcon;
  final VoidCallback enter;
  final VoidCallback onbutton;
  const DetailsButton({
    super.key,
    required this.buttonTxt,
    required this.buttonIcon,
    required this.autofocus,
    required this.enter,
    required this.onbutton,
  });

  @override
  State<DetailsButton> createState() => _DetailsButtonState();
}

class _DetailsButtonState extends State<DetailsButton> {
  FocusNode _detailsButtonNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    _detailsButtonNode.dispose();
    super.dispose();
  }
  var tileColor = Colors.transparent;
  var sigma = 0.0;
  var borderColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child)=> Padding(
        padding: const EdgeInsets.all(8.0),
        child: Focus(
          focusNode: _detailsButtonNode,
          autofocus: widget.autofocus,
          onFocusChange: (hasFocus){
            setState(() {
              tileColor = hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.2):Colors.transparent;
              sigma = (data.enableGlassMorphism == true)?hasFocus?10.0:0.0:0.0;
              borderColor = (data.enableGlassMorphism == true)?hasFocus?data.tertiaryColor.withOpacity(0.3):Colors.transparent:Colors.transparent;
            });
            /*if(hasFocus){
              Scrollable.ensureVisible(
                context,
                alignment: 0.5,
                duration: Duration(milliseconds: 700),
                curve: Curves.easeInOut,
                alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
              );
            }*/
          },
          onKeyEvent: (_detailsButtonNode,event){
            if(event is KeyDownEvent){
              if(event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.select){
                widget.enter();
                return KeyEventResult.handled;
              }else{
                widget.onbutton();
              }
            }
            return KeyEventResult.ignored;
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: sigma,sigmaX: sigma),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: tileColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1,color: borderColor)
                ),
                width: MediaQuery.of(context).size.width*0.3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                  child: Row(
                    children: [
                      Text(widget.buttonTxt),
                      Spacer(),
                      Icon(widget.buttonIcon,size: 20,),
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../functionality/app_logic.dart';
class SettingsTiles extends StatefulWidget {
  final String buttonName;
  final VoidCallback onEnter;
  final bool autofocus;
  final Widget action;
  const SettingsTiles({
    super.key,
    required this.buttonName,
    required this.onEnter,
    required this.autofocus,
    required this.action,
  });

  @override
  State<SettingsTiles> createState() => _SettingsTilesState();
}

class _SettingsTilesState extends State<SettingsTiles> {
  FocusNode _settingNode = FocusNode();
  var color = Colors.transparent;
  var sigma = 0.0;
  var borderColor = Colors.transparent;
  @override
  void dispose() {
    // TODO: implement dispose
    _settingNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<AppLogic>(
      builder:(context,data,child)=> Padding(
        padding: const EdgeInsets.all(8.0),
        child: Focus(
          focusNode: _settingNode,
          autofocus: widget.autofocus,
          onFocusChange: (hasFocus){
            setState(() {
              color = hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.2):Colors.transparent;
              sigma = (data.enableGlassMorphism == true)?hasFocus?10.0:0.0:0.0;
              borderColor = (data.enableGlassMorphism == true)?hasFocus?data.tertiaryColor.withOpacity(0.3):Colors.transparent:Colors.transparent;
            });
          },
          onKeyEvent: (_focusNode,event){
            if(event is KeyDownEvent){
              if(event.logicalKey == LogicalKeyboardKey.enter){
                widget.onEnter();
              }
            }
            return KeyEventResult.ignored;
          },
          child: AnimatedContainer(
            width: MediaQuery.of(context).size.width*0.3,
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1,color: borderColor)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigma,sigmaY: sigma),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.buttonName),
                      widget.action,
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

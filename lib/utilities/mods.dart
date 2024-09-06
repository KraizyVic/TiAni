import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/theme/theme.dart';
class ModedAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget action1;
  final Widget action2;
  final Widget action3;
  const ModedAppBar({
    super.key,
    this.leading,
    required this.action1,
    required this.action2,
    required this.action3,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: Colors.orange,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      leading: (leading != null)? leading: ModedIconButton(
        onPressed: ()=>Navigator.pop(context),
        icon: CupertinoIcons.chevron_left,
      ),
      actions: [
        /*SizedBox(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        hintText: "Search",
                        suffix: Icon(Icons.search,color: Colors.black87,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  ),
                ),*/
        action1,
        action2,
        action3,
      ],
    );
  }
}
class ModedIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const ModedIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  State<ModedIconButton> createState() => _ModedIconButtonState();
}

class _ModedIconButtonState extends State<ModedIconButton> {
  final FocusNode _focusNode = FocusNode();

  var boxcolor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child)=> Focus(
        focusNode: _focusNode,
        onFocusChange: (hasFocus){
          setState(() {
            //iconColor = hasFocus?data.tertiaryColor:Theme.of(context).colorScheme.secondary;
            boxcolor = hasFocus?data.tertiaryColor.withOpacity(0.15):Colors.transparent;
          });
        },
        onKeyEvent: (_focusNode,event){
          if(event is KeyDownEvent){
            if (event.logicalKey == LogicalKeyboardKey.enter){
              Feedback.forTap(context);
              widget.onPressed();
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: boxcolor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                widget.icon,
                color: (data.currentTheme==lightTheme && data.tertiaryColor == Colors.white)?_focusNode.hasFocus?Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.secondary.withOpacity(0.5):_focusNode.hasFocus?data.tertiaryColor:Theme.of(context).colorScheme.secondary.withOpacity(0.6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*focusNode: _focusNode,
        */

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:tiani/functionality/app_logic.dart";

/*class PreferenceSwitch extends StatefulWidget {
  final String switchName;
  final bool switchValue;
  final ValueChanged<bool> onchanged;
  const PreferenceSwitch({
    super.key,
    required this.switchName,
    required this.switchValue,
    required this.onchanged,
  });

  @override
  State<PreferenceSwitch> createState() => _PreferenceSwitchState();
}

class _PreferenceSwitchState extends State<PreferenceSwitch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:MediaQuery.of(context).size.width*0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.switchName),
          Switch(
            focusColor: Colors.transparent,
            inactiveTrackColor: Theme.of(context).canvasColor.withOpacity(0.6),
            activeTrackColor: Provider.of<AppLogic>(context).tertiaryColor.withOpacity(0.5),
            trackOutlineColor: WidgetStateProperty. resolveWith<Color?>((Set<WidgetState> states) {
              if (states. contains(WidgetState.focused)) {
                return Provider.of<AppLogic>(context).tertiaryColor;
              }
              return Provider.of<AppLogic>(context).tertiaryColor.withOpacity(0.4); // Use the default color.
            }),
            value: widget.switchValue,
            onChanged: widget.onchanged,
          )
        ],
      ),
    );
  }
}*/

class PreferenceSwitch extends StatefulWidget {
  final String switchName;
  final bool switchValue;
  final ValueChanged<bool> onChanged;

  const PreferenceSwitch({
    super.key,
    required this.switchName,
    required this.switchValue,
    required this.onChanged,
  });

  @override
  State<PreferenceSwitch> createState() => _PreferenceSwitchState();
}

class _PreferenceSwitchState extends State<PreferenceSwitch> {
  late bool _switchValue;

  @override
  void initState() {
    super.initState();
    _switchValue = widget.switchValue;
  }

  void _handleSwitchChange(bool value) {
    setState(() {
      _switchValue = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.switchName),
          Switch(
            focusColor: Colors.transparent,
            inactiveTrackColor: Theme.of(context).canvasColor.withOpacity(0.6),
            activeTrackColor: Provider.of<AppLogic>(context).tertiaryColor.withOpacity(0.5),
            trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
              if (states.contains(WidgetState.focused)) {
                return Provider.of<AppLogic>(context).tertiaryColor;
              }
              return Provider.of<AppLogic>(context).tertiaryColor.withOpacity(0.4); // Use the default color.
            }),
            value: _switchValue,
            onChanged: _handleSwitchChange,
          ),
        ],
      ),
    );
  }
}

class PreferenceButton extends StatefulWidget {
  final String buttonName;
  final IconData icon;
  const PreferenceButton({
    super.key,
    required this.buttonName,
    required this.icon,
  });

  @override
  State<PreferenceButton> createState() => _PreferenceButtonState();
}

class _PreferenceButtonState extends State<PreferenceButton> {
  FocusNode _settingNode = FocusNode();
  var color = Colors.transparent;
  @override
  void dispose() {
    // TODO: implement dispose
    _settingNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _settingNode,
      autofocus: false,
      onFocusChange: (hasFocus){
        setState(() {
          color = _settingNode.hasFocus?Theme.of(context).colorScheme.secondary.withOpacity(0.2):Colors.transparent;
        });
      },
      onKeyEvent: (_focusNode,event){
        if(event is KeyDownEvent){
          if(event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.select){
            print("Enter pressed");
            Feedback.forTap(context);
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width*0.4,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.buttonName),
              Icon(widget.icon),
            ],
          ),
        ),
      ),
    );
  }
}


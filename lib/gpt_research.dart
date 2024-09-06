/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiani/pages/details_page.dart';
import 'package:tiani/utilities/home_banner.dart';

import 'functionality/app_logic.dart';
import 'functionality/data.dart';
class HomeTile extends StatefulWidget {
  final String image;
  final bool autofocus;
  final FocusNode focusNode; // Add this line
  const HomeTile({
    super.key,
    required this.image,
    required this.autofocus,
    required this.focusNode, // Add this line
  });

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  // Remove the local FocusNode
  var tileBackground = Colors.transparent;
  var _width = 100.0;
  var _borderColor = Colors.transparent;

  @override
  void dispose() {
    // Do not dispose the FocusNode here as it will be managed by the parent widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Focus(
        focusNode: widget.focusNode, // Use the passed FocusNode
        autofocus: widget.autofocus,
        onFocusChange: (hasFocus) {
          setState(() {
            tileBackground = hasFocus
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                : Colors.transparent;
            _borderColor = hasFocus
                ? Provider.of<AppLogic>(context, listen: false).tertiaryColor.withOpacity(.4)
                : Colors.transparent;
          });
        },
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.enter) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(image: widget.image)));
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(image: widget.image)));
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: double.maxFinite,
            width: _width,
            decoration: BoxDecoration(
                color: tileBackground,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: _borderColor)
            ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Image.asset(
                          widget.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Gojo Sensei", overflow: TextOverflow.ellipsis),
                        Row(
                          children: [
                            Icon(Icons.star, size: 15),
                            SizedBox(width: 5),
                            Text("9.0"),
                            SizedBox(width: 5),
                            Text("(2024)", overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _firstTileFocusNode = FocusNode();
  bool autofocus = false;

  void changeFocusToFirstTile() {
    _firstTileFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _firstTileFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeBanner(
            changeFocus: changeFocusToFirstTile, // Ensure this is called to change focus
            onKeyDown: () {
              setState(() {
                autofocus = true;
              });
            },
            onKeyUp: () {
              setState(() {
                autofocus = false;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Popular"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagesData.length,
              itemBuilder: (context, index) {
                return HomeTile(
                  image: imagesData[index],
                  autofocus: index == 0 && autofocus,
                  focusNode: index == 0 ? _firstTileFocusNode : FocusNode(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}*/

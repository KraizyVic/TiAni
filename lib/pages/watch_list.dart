import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/utilities/constants.dart';

import '../utilities/dummy_widgets.dart';
import '../utilities/home_tile.dart';
class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  final FocusNode _movieNode = FocusNode();
  final FocusNode _serriesNode = FocusNode();
  final FocusNode _uncategorisedNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _movieNode.dispose();
    _serriesNode.dispose();
    _uncategorisedNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child)=> Scaffold(
        backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  data.accounnts[data.currentAccount].movieList.isNotEmpty ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "Movies",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text(
                              "Total: ${data.accounnts[data.currentAccount].movieList.length}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height*homeTileHeight,
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.6/1),
                              itemCount: data.accounnts[data.currentAccount].movieList.length,
                              itemBuilder: (context,index){
                                return HomeTile(
                                  anime: data.accounnts[data.currentAccount].movieList.toList()[index],
                                  focusNode: index == 0 ? _movieNode : FocusNode(),
                                  autofocus: index == 0,
                                  onDown: ()=>_serriesNode.requestFocus(),
                                );
                              }
                          )
                      ),
                    ],
                  ):SizedBox(),
                  data.accounnts[data.currentAccount].tvList.isNotEmpty?Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tv Serries",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text(
                              "Total: ${data.accounnts[data.currentAccount].tvList.length}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height*homeTileHeight,
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.6/1),
                              itemCount: data.accounnts[data.currentAccount].tvList.length,
                              itemBuilder: (context,index){
                                return HomeTile(
                                  focusNode: index == 0 ? _serriesNode : FocusNode(),
                                  autofocus: false,
                                  onDown: ()=> _uncategorisedNode.requestFocus(), anime: data.accounnts[data.currentAccount].tvList.toList()[index],
                                );
                              }
                          )
                      ),
                    ],
                  ):SizedBox(),
                  data.accounnts[data.currentAccount].uncategorisedList.isNotEmpty?Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "Uncategorised",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text(
                              "Total: ${data.accounnts[data.currentAccount].uncategorisedList.length}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height*homeTileHeight,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.6/1),
                            itemCount: data.accounnts[data.currentAccount].uncategorisedList.length,
                            itemBuilder: (context,index){
                              return HomeTile(
                                autofocus: false,
                                focusNode: index == 0 ? _uncategorisedNode : FocusNode(),
                                anime: data.accounnts[data.currentAccount].uncategorisedList.toList()[index],
                              );
                            }
                          )
                      ),
                    ],
                  ):SizedBox(),
                ],
              ),
            ),
          )
        /*Center(
          child: Text(
            "Films you add appear here"
          ),
        )*/
      ),
    );
  }
}

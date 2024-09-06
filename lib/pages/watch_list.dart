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
                          "Total: ${data.accounnts[data.currentAccount].movieList}",
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
                          itemCount: data.accounnts[data.currentAccount].movieList,
                          itemBuilder: (context,index){
                            return DummyHomeTile(
                              focusNode: index == 0 ? _movieNode : FocusNode(),
                              image: "imagesData[index]",
                              autofocus: index == 0,
                              onDown: ()=>_serriesNode.requestFocus(),
                            );
                          }
                      )
                  ),
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
                          "Total: ${data.accounnts[data.currentAccount].tvList}",
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
                          itemCount: data.accounnts[data.currentAccount].tvList,
                          itemBuilder: (context,index){
                            return DummyHomeTile(
                              focusNode: index == 0 ? _serriesNode : FocusNode(),
                              image: "imagesData[index]",
                              autofocus: false,
                              onDown: ()=> _uncategorisedNode.requestFocus(),
                            );
                          }
                      )
                  ),
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
                          "Total: ${data.accounnts[data.currentAccount].uncategorisedList}",
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
                          itemCount: data.accounnts[data.currentAccount].uncategorisedList,
                          itemBuilder: (context,index){
                            return DummyHomeTile(
                              focusNode: index == 0 ? _uncategorisedNode : FocusNode(),
                              image: "",
                              autofocus: false,
                            );
                          }
                      )
                  ),
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

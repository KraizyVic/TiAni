import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/models/anime_model.dart';
import 'package:tiani/models/review_model.dart';
import 'package:tiani/pages/account_page.dart';
import 'package:tiani/pages/main_page.dart';
import 'package:tiani/pages/settings_page.dart';
import 'package:tiani/services/anime_service.dart';
import 'package:tiani/utilities/detail_items.dart';
import 'package:tiani/utilities/mods.dart';
import 'package:tiani/utilities/review_items.dart';
class ReviewPage extends StatefulWidget {
  final ReviewModel review;
  final AnimeModel anime;
  final int index;
  const ReviewPage({
    super.key,
    required this.review,
    required this.anime,
    required this.index,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late FocusNode _moreReviewsNode ;
  FocusNode _userNode = FocusNode();
  FocusNode _reviewNode = FocusNode();
  ScrollController _scrollController = ScrollController();
  late String date;
  Color userBorder = Colors.transparent;
  Color reviewBorder = Colors.transparent;
  late Future <List<ReviewModel>> moreReviews;
  @override
  void initState() {
    // TODO: implement initState
    _moreReviewsNode = FocusNode();
    moreReviews = AnimeService().getanimeReviews(widget.anime.malId);
    DateTime parsed = DateTime.parse(widget.review.date);
    date = DateFormat('yyyy-mm-dd').format(parsed);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _moreReviewsNode.dispose();
    _userNode.dispose();
    _reviewNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child)=> Scaffold(
        body: Stack(
          children: [
            Image.network(
              widget.anime.trailerImage,//"https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/fecfc769-eca8-495b-baba-ca4f58048dc7/dgg4ezo-bb06684f-8bc6-4de1-9137-614e54d3990f.png/v1/fit/w_828,h_466,q_70,strp/mei_mei_scene_05_jujutsu_kaisen_s02ep12_by_michaelxgamingph_dgg4ezo-414w-2x.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NzIwIiwicGF0aCI6IlwvZlwvZmVjZmM3NjktZWNhOC00OTViLWJhYmEtY2E0ZjU4MDQ4ZGM3XC9kZ2c0ZXpvLWJiMDY2ODRmLThiYzYtNGRlMS05MTM3LTYxNGU1NGQzOTkwZi5wbmciLCJ3aWR0aCI6Ijw9MTI4MCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.aiahi6tVKPZ142Rfp5FDvNsUWwYmckKdncVQK_2GsDU",
              fit: BoxFit.cover,
              height: double.maxFinite,
              width: double.maxFinite,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Theme.of(context).canvasColor.withOpacity(0.9),Theme.of(context).canvasColor.withOpacity(0.2)])
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Theme.of(context).canvasColor.withOpacity(0.5),Colors.transparent],begin: Alignment.topCenter,end: Alignment.center)
              ),
            ),
            Column(
              children: [
                ModedAppBar(
                  action1: ModedIconButton(onPressed: ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MainPage())), icon: HugeIcons.strokeRoundedHome09),
                  action2: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>AccountPage())), icon: HugeIcons.strokeRoundedUserCircle),
                  action3: ModedIconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingsPage())), icon: HugeIcons.strokeRoundedSettings03)
                ),
                Expanded(
                    child: Container(
                      color: Colors.red.withOpacity(0),
                      child: Row(
                        children: [
                        Expanded(
                          child: Container(
                            color: Colors.blue.withOpacity(0),
                            height: double.maxFinite,
                            child: Column(
                              children: [
                                Text(widget.anime.title,style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 20,sigmaY: 20),
                                      child: Container(
                                        //margin: EdgeInsets.symmetric(horizontal: 50,vertical: 100),
                                        height: MediaQuery.of(context).size.height*0.43,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.secondary.withOpacity(.2),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(width: 1,color: userBorder)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(image: NetworkImage(widget.review.image),fit: BoxFit.cover)
                                                      ),
                                                    ),
                                                    Text(widget.review.userName),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              Text(date),
                                                              widget.review.isSpoiler==true?Text("SPOILER"):Text("Preliminary"),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                                          child: Container(
                                                            width: 1,
                                                            height: MediaQuery.of(context).size.height*0.11,
                                                            color: data.tertiaryColor,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text("Rating: "),
                                                                  SizedBox(width: 5,),
                                                                  Icon(Icons.star,size: 18,color: data.tertiaryColor,),
                                                                  SizedBox(width: 5,),
                                                                  Text(widget.review.score.toString()),
                                                                ],
                                                              ),
                                                              Text(widget.review.tag),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                child: SizedBox(
                                                  height: double.maxFinite,
                                                  width: 130,
                                                  child: Column(
                                                    children: [
                                                      Text("Reactions",style: TextStyle(fontSize: 18),),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            SizedBox(height: 3,),
                                                            Reaction(reaction:"😐 Overall :", metric:widget.review.reactions.overall),
                                                            Reaction(reaction:"😊 Nice :",metric: widget.review.reactions.nice),
                                                            Reaction(reaction:"😆 Funny :",metric: widget.review.reactions.funny),
                                                            Reaction(reaction:"😕 Confusing:",metric: widget.review.reactions.confusing),
                                                            Reaction(reaction:"😍 Love it :",metric: widget.review.reactions.loveIt),
                                                            Reaction(reaction:"💁 Informative :",metric: widget.review.reactions.informative),
                                                            Reaction(reaction:"✍️ Well written :",metric: widget.review.reactions.wellWritten),
                                                            Reaction(reaction:"🤯 Creative :",metric: widget.review.reactions.creative),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
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
                                          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 20),
                                          child: Text("More reviews", style: TextStyle(fontSize: 20),),
                                        ),
                                        Expanded(
                                          child: FutureBuilder(
                                              future: moreReviews,
                                              builder: (context,snapshot){
                                                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                                                  snapshot.data!.removeAt(widget.index);
                                                  return ListView.builder(
                                                    itemCount: snapshot.data!.length,
                                                    itemBuilder: (context,index)=>ReviewTile(
                                                      focusNode: index == 0 ?  _moreReviewsNode : FocusNode(),
                                                      review: snapshot.data![index],
                                                      anime: widget.anime,
                                                      index: index,
                                                      onEnter: ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ReviewPage(review: snapshot.data![index], anime: widget.anime, index: index))),
                                                    )
                                                  );
                                                }else if (snapshot.hasError){
                                                  return Center(child: Text("Error"),);
                                                }else{
                                                  return Center(child: CircularProgressIndicator(color: data.tertiaryColor,),);
                                                }
                                              }
                                          ),
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
                          )
                        ),
                        Container(width: 1,height: MediaQuery.of(context).size.height*0.6,color: data.tertiaryColor,),
                        Expanded(
                          child: Container(
                            color: Colors.yellow.withOpacity(0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height:50,
                                    child: Text("Review",style: TextStyle(fontSize: 20),)
                                ),
                                Expanded(
                                  child: Focus(
                                    focusNode: _reviewNode,
                                    autofocus: true,
                                    onFocusChange: (hasFocus){
                                      setState(() {
                                        reviewBorder = hasFocus?data.tertiaryColor:Colors.transparent;
                                      });
                                    },
                                    onKeyEvent: (_reviewNode,event){
                                      if(event.logicalKey == LogicalKeyboardKey.arrowDown){
                                        _scrollController.animateTo(_scrollController.offset + 100, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                                        return KeyEventResult.handled;
                                      }else if(event.logicalKey == LogicalKeyboardKey.arrowUp){
                                        if(_scrollController.offset == 0){
                                          _reviewNode.unfocus();
                                        }else{
                                          _scrollController.animateTo(_scrollController.offset - 100, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                                        }
                                        return KeyEventResult.handled;
                                      }else if(event.logicalKey == LogicalKeyboardKey.arrowLeft){
                                        _moreReviewsNode.requestFocus();
                                        return KeyEventResult.handled;
                                      }
                                      return KeyEventResult.ignored;
                                    },
                                    child: SingleChildScrollView(
                                      controller: _scrollController,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 20,sigmaY: 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.secondary.withOpacity(.2),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(width: 1,color: reviewBorder)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  widget.review.review,
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        ],
                      ),
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

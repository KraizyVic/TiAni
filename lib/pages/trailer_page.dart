import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/models/anime_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class TrailerPage extends StatefulWidget {
  final AnimeModel anime;
  const TrailerPage({
    super.key,
    required this.anime,
  });

  @override
  State<TrailerPage> createState() => _TrailerPageState();
}
class _TrailerPageState extends State<TrailerPage> {
  late String youtubeId ;
  late YoutubePlayerController _controller;
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    youtubeId = YoutubePlayer.convertUrlToId(widget.anime.trailer)!;
    _controller = YoutubePlayerController(
      initialVideoId: youtubeId,
      flags: YoutubePlayerFlags(
        disableDragSeek: true,
        controlsVisibleAtStart: false,

      )
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context,data,child) => Focus(
        focusNode: _focusNode,
        onKeyEvent: (_focusNode,event){
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.pause || event.logicalKey == LogicalKeyboardKey.play || event.logicalKey == LogicalKeyboardKey.space ) {
              // Play/Pause the video
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
              return KeyEventResult.handled;
            } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              // Fast forward 10 seconds
              _controller.seekTo(_controller.value.position + Duration(seconds: 10));
              return KeyEventResult.handled;
            } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              // Rewind 10 seconds
              _controller.seekTo(_controller.value.position - Duration(seconds: 10));
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: data.tertiaryColor,
        controlsTimeOut: Duration(seconds: 5),
        progressColors:  ProgressBarColors(
          playedColor: data.tertiaryColor,
          handleColor: data.tertiaryColor,
          bufferedColor: data.tertiaryColor.withOpacity(0.3)
        ),
                  )
      ),
    );
  }
}


import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/qt/models/qt_info.dart';
import 'package:video_player/video_player.dart';

import '../../chewie_list_item.dart';




class QTInfoPage extends StatefulWidget {
  final QTInfo qtInfo;

  QTInfoPage({
    @required this.qtInfo,
  });

  @override
  _QTInfoPageState createState() => _QTInfoPageState();
}

class _QTInfoPageState extends State<QTInfoPage> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    print("start to _QTInfoPageState with qt: ${widget.qtInfo.date} - ${widget.qtInfo.title}");
    this.initializePlayer();
  }

  Future<void> initializePlayer() async {
    print("widget.qtInfo.videoUrl: ${widget.qtInfo.videoUrl}");
  _videoPlayerController = VideoPlayerController.network(
      widget.qtInfo.videoUrl);
    //_videoPlayerController = VideoPlayerController.asset('videos/test.mp4');
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,

      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
/**
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: false,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      //materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //  color: Colors.green,
      //),
      // autoInitialize: true,
    );
    */
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("qt")),
         body: SingleChildScrollView(
            child: Stack(
                children: <Widget>[_buildBody()]
            )
        ),
        bottomNavigationBar: buildBottomNavigationBar(context)
    );
  }

  Widget _buildBody() {
    _platform = Theme.of(context).platform;

   return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.qtInfo.date),
          Text(widget.qtInfo.title),
           _buildVideoPlayer(),
          Text(widget.qtInfo.content),
          ]
        );
  }
  Widget _buildVideoPlayer() {

    return
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _chewieController != null && _chewieController .videoPlayerController.value.initialized
                    ?
                    Chewie(
                      controller: _chewieController,
                    )
                    :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Loading'),
                      ],
                    )
              ) ;


  }

}



import 'dart:async';
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mydec/common/appbar.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/i10n/localization_intl.dart';
import 'package:mydec/qt/models/qt_info.dart';
import 'package:video_player/video_player.dart';

import 'package:floating_action_row/floating_action_row.dart';



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
  double titleFontSize;
  double subtitleFontSize;
  double contentFontSize;


  List<Widget> floatButtons = [];

  @override
  void initState() {
    super.initState();
    print("start to _QTInfoPageState with qt: ${widget.qtInfo.date} - ${widget.qtInfo.title}");
    this.initializePlayer();
    _showDefaultFloatActionButtons();

    titleFontSize = 20;
    subtitleFontSize = 14;
    contentFontSize = 14;
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
        // appBar: AppBar(title: Text(DecLocalizations.of(context).dailyQt)),

        appBar: buildAppBar(context,
            DecLocalizations.of(context).dailyQt,null),
         body: SingleChildScrollView(
            child: Stack(
                children: <Widget>[_buildBody()]
            )
        ),
        bottomNavigationBar: buildBottomNavigationBar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        // floatingActionButton: _buildFloatingActionButton(),
        floatingActionButton: FloatingActionRow(
          children: floatButtons,
          color: Colors.transparent,
          elevation: 0,
          height: 50,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(10),

          )
        ),
    );
  }

  Widget _buildBody() {

   return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.qtInfo.title,
          style:TextStyle(fontSize: titleFontSize ,fontWeight: FontWeight.bold)), //QT title bold
          Text(
              widget.qtInfo.date,
              style: TextStyle(fontSize: subtitleFontSize)// QT date
          ),
          _buildVideoPlayer(),
          Text(widget.qtInfo.content,
                style: TextStyle(wordSpacing: 10,
                    fontSize: contentFontSize,
                    letterSpacing: 2,
                      fontStyle: FontStyle.italic,),  ), // QT Main body
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


  _showDefaultFloatActionButtons() {
    print("_showDefaultFloatActionButtons");
    var buttons = List<Widget>();
    buttons.add(FloatingActionButton(
        elevation: 0.0,
        child: Image.asset('assets/images/text_format_button.png') ,
        backgroundColor: Colors.transparent,
        onPressed: () => _showActionButtons(),
    ));
    /**
    buttons.add(
      FloatingActionRowButton(
        icon: Icon(Icons.add),
        onTap: () => _showActionButtons(),
      ),
    );
        **/
    print("start to show default action button");
    setState(() {
      floatButtons = buttons;
    });
  }
  _showActionButtons() {
    print("_showActionButtons");
    var buttons = List<Widget>();
    buttons.add(
        FloatingActionButton(
            elevation: 0.0,
            child: Image.asset('assets/images/clear_text_format_button.png') ,
            backgroundColor: Colors.transparent,
            onPressed:() => _showDefaultFloatActionButtons(),
        )
    );
    buttons.add(
      FloatingActionRowDivider(),
    );
    buttons.add(
        FloatingActionButton(
          elevation: 0.0,
          child: Image.asset('assets/images/decrease_font_size_cn.png') ,
          backgroundColor: Colors.transparent,
          onPressed:() => _changeFontSize(-1),

        )
    );
    buttons.add(
      FloatingActionRowDivider(),
    );
    buttons.add(
        FloatingActionButton(
          elevation: 0.0,
          child: Image.asset('assets/images/increase_font_size_cn.png') ,
          backgroundColor: Colors.transparent,
          onPressed:() => _changeFontSize(1),
        )
    );
    print("start to show _showActionButtons");
    setState(() {
      floatButtons = buttons;
    });
  }
  _changeFontSize(int sizeChanged) {
    setState(() {
      titleFontSize += sizeChanged;
      subtitleFontSize += sizeChanged;
      contentFontSize += sizeChanged;
    });

  }
}


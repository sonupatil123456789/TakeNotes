import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/view/components/video_button.dart';
import 'package:video_player/video_player.dart';

bool expandedheight = false;
bool textellips = false;

class CoustomVideoPlayer extends StatefulWidget {
  dynamic notesData;

  CoustomVideoPlayer({
    super.key,
    required this.notesData,
  });

  @override
  State<CoustomVideoPlayer> createState() => _CoustomVideoPlayerState();
}

class _CoustomVideoPlayerState extends State<CoustomVideoPlayer> {
  late VideoPlayerController _controller;
  late dynamic data = null;

  var visibleopacity = 0.0;

  @override
  void initState() {
    super.initState();

    data = widget.notesData['notesData'];
    _controller = VideoPlayerController.networkUrl(Uri.parse(data['paragraph']))
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
      })
      ..play();
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#000000"),
        title: Text(data['title']),
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: HexColor('#000000'),
        child: Stack(children: [
          Container(
            height: screenheight,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Center(
                    child: CircularProgressIndicator(
                    color: HexColor("#0D2A3C"),
                    strokeWidth: 6,
                  )),
          ),
          Positioned(
            bottom: screenheight * 0.06,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: screenwidth,
                      height: screenheight * 0.01,
                      child: VideoProgressIndicator(_controller,
                          colors: const VideoProgressColors(
                              playedColor: Colors.white),
                          allowScrubbing: true)),
                ],
              ),
            ),
          ),
          Positioned(
              top: screenheight * 0.32,
              right: screenwidth * 0.35,
              child: Opacity(
                  opacity: visibleopacity,
                  child: Center(
                      child: _controller.value.isPlaying == true
                          ? controlButtons(
                              buttonfunction: () {
                                visibleopacity = 0.0;
                                Future.delayed(const Duration(seconds: 2), () {
                                  setState(() {
                                    visibleopacity = 1.0;
                                  });
                                });
                                setState(() {
                                  _controller.pause();
                                });
                              },
                              buttonname: Icons.pause,
                              buttonvalue: 'Play',
                            )
                          : controlButtons(
                              buttonfunction: () {
                                visibleopacity = 1.0;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    visibleopacity = 0.0;
                                  });
                                });
                                setState(() {
                                  _controller.play();
                                });
                              },
                              buttonname: Icons.play_arrow,
                              buttonvalue: 'Pause',
                            ))))
        ]),
      ),
    );
  }

  void dispose() {
    super.dispose();
    // timer.cancel();
    _controller.dispose();
  }
}

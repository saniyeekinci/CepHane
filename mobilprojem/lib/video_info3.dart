import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoInfo3 extends StatefulWidget {
  const VideoInfo3({Key? key}) : super(key: key);

  @override
  State<VideoInfo3> createState() => _VideoInfo3State();
}

class _VideoInfo3State extends State<VideoInfo3> {
  List<Map<String, dynamic>> videoInfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  VideoPlayerController? _controller;

  Future<void> _initData() async {
    try {
      String data = await DefaultAssetBundle.of(context).loadString("assets/json/videoinfo3.json");
      List<dynamic> decodedData = json.decode(data);
      List<Map<String, dynamic>> typedData = decodedData.cast<Map<String, dynamic>>();
      setState(() {
        videoInfo = typedData;
      });
    } catch (e) {
      print("Error loading video info: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _playArea == false
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [
                    Colors.orange.shade500,
                    Colors.orange.shade800,
                  ],
                ),
              )
            : BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [
                    Colors.orange.shade500,
                    Colors.orange.shade800,
                  ],
                ),
              ),
        child: Column(
          children: [
            _playArea == false
                ? Container(
                    padding: const EdgeInsets.only(top: 40, left: 20, right: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: Colors.white70,
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Eğitim Sadece Bir ",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Dokunuş Uzağınızda",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white70,
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Colors.white70,
                        )
                      ],
                    ),
                  ),
                  _playView(context),
                  _controlView(context)
                ],
              ),
            ),

            Expanded(
              child: Container(
                // Video beyaz kısım
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Text(
                          "AYT'nin En Sağlamları",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: _listView(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _controlView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {},
          icon: Icon(Icons.fast_rewind, size: 36, color: Colors.black),
        ),
        IconButton(
          onPressed: () async {
            if (_isPlaying) {
              _controller?.pause();
            } else {
              _controller?.play();
            }
            setState(() {
              _isPlaying = !_isPlaying;
            });
          },
          icon: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            size: 36,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () async {},
          icon: Icon(Icons.fast_forward, size: 36, color: Colors.black),
        ),
      ],
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Text(
            "Yükleniyor...",
            style: TextStyle(fontSize: 20, color: Colors.white70),
          ),
        ),
      );
    }
  }

  _initializeVideo(int index) async {
    if (videoInfo.isEmpty || index >= videoInfo.length) {
      return;
    }
    final videoUrl = videoInfo[index]["VideoURL"];
    if (videoUrl == null || videoUrl.isEmpty) {
      print("Invalid video URL");
      return;
    }
    final oldController = _controller;
    _controller = VideoPlayerController.networkUrl(videoUrl);

    await oldController?.dispose();
    setState(() {});

    _controller?.initialize().then((_) {
      setState(() {
        _isPlaying = true;
      });
      _controller?.play();
    }).catchError((error) {
      print("Error initializing video: $error");
    });
  }

  _onTapVideo(int index) {
    _initializeVideo(index);
    setState(() {
      if (_playArea == false) {
        _playArea = true;
      }
    });
  }

  _listView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      itemCount: videoInfo.length,
      itemBuilder: (_, int index) {
        return GestureDetector(
          onTap: () {
            _onTapVideo(index);
          },
          child: _buildCard(index),
        );
      },
    );
  }

  _buildCard(int index) {
    return Container(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(videoInfo[index]["thumbnail"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoInfo[index]["title"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      videoInfo[index]["time"],
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "5 dk dinlenme",
                    style: TextStyle(color: Color(0xFF839fed)),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
                    i.isEven
                        ? Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                              color: Color(0xFF839fed),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          )
                        : Container(
                            width: 3,
                            height: 1,
                            color: Colors.white,
                          )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

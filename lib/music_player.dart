import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class MusicPlayer extends StatefulWidget {
  MusicPlayer ({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
   audioPlayer.onPlayerStateChanged.listen((state) {
     setState(() {
       isPlaying = state == PlayerState.PLAYING;
     });
   });
   audioPlayer.onDurationChanged.listen((newDuration) {
     setState(() {
       duration = newDuration;
     });
   });
   audioPlayer.onAudioPositionChanged.listen((newPosition) {
     setState(() {
       position = newPosition;
     });
   });
    super.initState();
  }
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/background.png',
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Text('Songs',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 5),
            Text('Songs',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black),
            ),
            SizedBox(height: 5),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async{},
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(duration)),
                  Text(formatTime(duration-position)),
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
                  onPressed:() async{
                    if(isPlaying){
                      await audioPlayer.pause();
                    }else{
                      String url = "http://sndup.net/kqgd";
                      await audioPlayer.play(url);
                    }
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
  String formatTime(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if(duration.inHours > 0) hours,minutes,seconds,].join(':');
  }
}

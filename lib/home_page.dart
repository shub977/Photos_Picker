import 'dart:io';
import 'package:camera_project/music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
  @override
  Widget build(BuildContext context) {
    Future pickImage(ImageSource source) async{
      try{
        final image = await ImagePicker().pickImage(source: source);
        if(image == null) return;
        final imageTemporary = File(image.path);
        setState(() =>
        this.image = imageTemporary);
      } on PlatformException catch (e){
        print('Failed to pick image:$e');
      }
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber.shade300,
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Spacer(),
              image != null ? Image.file(image!,
               width: 160,
               height: 160,
               fit: BoxFit.cover,
              )
                  :FlutterLogo(size: 160),
              Text('Image Picker',
                style: TextStyle(
                  color: Colors.black,fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 35.0, left: 35.0,bottom: 5),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromRGBO(2, 141, 153, 1),
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> MusicPlayer()));
                    },
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 15,right: 15),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    child: Text('Pick Gallery'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(2, 141, 153, 1),
                      //side: BorderSide(color: Colors.white, width: 20),
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontStyle: FontStyle.normal),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      shadowColor: Colors.lightBlue,
                    ),
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding:  EdgeInsets.only(left: 15,right: 15,bottom: 5),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    child: Text('Pick Camera'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(2, 141, 153, 1),
                      //side: BorderSide(color: Colors.white, width: 20),
                      textStyle:  TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontStyle: FontStyle.normal),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      shadowColor: Colors.lightBlue,
                    ),
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

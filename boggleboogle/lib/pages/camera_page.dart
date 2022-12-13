import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'database_key.dart';
import 'calendar_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  int a = 0;
  final picker = ImagePicker();
  FirebaseDatabase? _database;
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference? reference;
  String _databaceURL =
      'https://bogleboogle-default-rtdb.asia-southeast1.firebasedatabase.app/';

  List<Boggle> glegle = List.empty(growable: true);
  @override
  void initState() {
    super.initState();
  }

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    setState(() {
      _image = File(image!.path);
    });
  }

  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: _image == null
            ? const Text('No image selected.')
            : Image.file(File(_image!.path)));
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        backgroundColor: const Color(0xfff4f3f9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25.0),
            showImage(),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[_wantButton()],

              // FloatingActionButton(
              //   tooltip: 'save Image',
              //   onPressed: () {
              //     uploadFile(context)
              // ),
            )
          ],
        ));
  }

  _wantButton() {
    if (_image == null) {
      return _button1();
    } else {
      return _button2();
    }
  }

  Widget _button1() {
    return FloatingActionButton(
      tooltip: 'pick Image',
      onPressed: () {
        getImage(ImageSource.camera);
      },
      child: const Icon(Icons.add_a_photo),
    );
  }

  Widget _button2() {
    return FloatingActionButton(
      tooltip: 'upload Image',
      onPressed: () {
        // 1 을 추가해주는 코드를 작성하면 되고

        Get.to(() => const CalendarPage(mail: "alro92333@gmail.com", totoday: "1"));
      },
      child: const Icon(Icons.upload),
    );
  }
}

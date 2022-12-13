import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'setting_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:boggleboogle/components/calendar_compo.dart';
import 'my_home_page.dart';
import 'chat_page.dart';
import 'friend_main_page.dart';
import 'friend_page.dart';
import 'camera_page.dart';

class CalendarPage extends StatefulWidget {
  final mail;
  final totoday;
  const CalendarPage({
    Key? key,
    @required this.mail,
    @required this.totoday,
  }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDay;
  String? user_id;
  String strToday = "2022-11-25";
  String isDoneToday = "no";
  String? user_name;
  String nick_name = "보글부글";

  Map<String, String> calen = {};
  List<String> dateList = [];

  _readData() async {
    String? eid;
    final user = FirebaseAuth.instance.currentUser;

    final userRef =
        await FirebaseFirestore.instance.collection("users").doc(widget.mail);
    await userRef.get().then((DocumentSnapshot doc) {
      user_name = doc['name'];
      nick_name = doc['nickname'];
      if (kDebugMode) {
        print(user_name);
      }
      if (kDebugMode) {
        print(nick_name);
      }
    });
    strToday = getToday();
    final userRef2 = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.mail)
        .collection("Dates")
        .doc(strToday);
    userRef2.get().then((DocumentSnapshot doc) {
      isDoneToday = doc['isDone'];
      if (kDebugMode) {
        print(strToday);
      }
      if (kDebugMode) {
        print(isDoneToday);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    strToday = getToday();
    _readData().then((value) {});
    ;
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("로그아웃에 성공했습니다."),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("로그아웃에 실패했습니다."),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futures(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    //child: Text('Awaiting result...'),
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: _bulidMainAppbar(),
              drawer: _bulidMainDrawer(),
              body: Column(
                children: [
                  CalendarCom(
                    mail: widget.mail,
                    totoday: widget.totoday,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const CameraPage());
                    },
                    child: const Icon(Icons.camera_alt_outlined),
                  ),
                ],
              ),
            );
            ;
          }
        });
    //보글이 부글이 데이터
    //Future<String>
    //backgroundColor: Color.fromARGB(255, 171, 199, 100),
  }

  //Appbar
  AppBar _bulidMainAppbar() => AppBar(
        title: const Text("보글부글"),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            //padding: EdgeInsets.only(right: 320.0),
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            //padding: EdgeInsets.only(right: 50.0),
            icon: const Icon(Icons.people),

            onPressed: () {
              Get.to(() => FriendScreen(
                    mail: widget.mail,
                    username: user_name,
                    nickname: nick_name,
                  ));
            },
          )
        ],
      );
  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    strToday = formatter.format(now);
    return strToday;
  }

  Widget _boggle() {
    return SizedBox(
      //margin: EdgeInsets.all(10),
      width: 80,
      height: 80,
      //margin: EdgeInsets.all(10),
      child: Image.asset(
          'assets/images/boggle.png'),
    );
  }

  Widget _bbogle() {
    return SizedBox(
      //margin: EdgeInsets.all(10),
      width: 80,
      height: 80,
      //margin: EdgeInsets.all(10),
      child: Image.asset(
          'assets/images/bbogle.png'),
    );
  }


  Widget _boogle() {
    return SizedBox(
      //margin: EdgeInsets.all(10),
      width: 80,
      height: 80,
      //margin: EdgeInsets.all(10),
      child: Image.asset(
          'assets/images/boogle.png'),
    );
  }

  _image() {
    if (isDoneToday == "0"||widget.totoday=="1") {
      if (kDebugMode) {
        print("today");
      }
      return _boggle();
    } else if(isDoneToday == "1"){
      if (kDebugMode) {
        print("not today");
      }
      return _boogle();
    }
    else {
      return _bbogle();
    }
  }

  Future _futures() async {
    await Future.delayed(const Duration(seconds: 1));
    return '빌드 시작';
  }

  //Drawer
  Drawer _bulidMainDrawer() => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            //Text('프로필'),
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: ListView(
                children: [
                  const Text("프로필"),
                  ListTile(
                    title: Text(
                      nick_name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: _image(),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('설정'),
              onTap: () {
                Get.to(() => SettingPage());
              },
            ),
            ListTile(
              title: const Text('로그아웃'),
              onTap: () {
                signOut();
                Get.offAll(() => const MyHomePage());
              },
            ),
          ],
        ),
      );
}

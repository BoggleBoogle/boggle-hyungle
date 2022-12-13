//import 'dart:html';
//
import 'dart:collection';
import 'dart:async';
//import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarCom extends StatefulWidget {
  final mail;
  final totoday;
  const CalendarCom({Key? key, required this.mail, required this.totoday})
      : super(key: key);
  @override
  State<CalendarCom> createState() => _CalendarComState();
}

class _CalendarComState extends State<CalendarCom> {
  String? user_id;
  String? day_return;
  String? is_done;

  _getData() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      user_id = user?.email;
      if (kDebugMode) {
        print(user_id);
      }
    });
  }

  Map<String, String> calen = {};
  List<String> dateList = [];

  _listDate() async {
    final user = FirebaseAuth.instance.currentUser;
    String? eid;

    final userRef = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.mail)
        .collection("Dates");
    await userRef.get().then((value) {
      for (var element in value.docs) {
        dateList.add(element.id);
        eid = element.id;
        if (kDebugMode) {
          print(eid);
        }
        if (kDebugMode) {
          print(dateList);
        }
      }
    });

    for (var element in dateList) {
      final user2Ref = FirebaseFirestore.instance
          .collection("users")
          .doc(widget.mail)
          .collection("Dates")
          .doc(element);
      user2Ref.get().then((DocumentSnapshot doc) {
        calen[element] = doc['isDone'];
        if (kDebugMode) {
          print("출력");
        }
        if (kDebugMode) {
          print(element);
        }
        if (kDebugMode) {
          print(calen[element]);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _listDate().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futures(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return const CircularProgressIndicator();
          } else {
            return _calendar();
          }
        });
    //보글이 부글이 데이터
    //Future<String>
    //backgroundColor: Color.fromARGB(255, 171, 199, 100),
  }

  TableCalendar _calendar() => TableCalendar(
        firstDay: DateTime.utc(2015, 1, 1),
        lastDay: DateTime.utc(2050, 12, 31),
        focusedDay: DateTime.now(),
        locale: 'ko-KR',
        //daysOfWeekHeight: 10,
        rowHeight: 70,

        eventLoader: (day) {
          final dateStr = DateFormat('yyyy-MM-dd').format(day);
          day_return = dateStr;
          String? future;
          future = calen[day_return];
          //print(future);
          if (future == "0") {
            if (kDebugMode) {
              print("read 실행");
            }
            return ['boggle', 'boogle'];
          } else if (future == "1") {
            return ['hi'];
          } else if (widget.totoday == "1" && DateTime.now().day == day.day) {
            return ['boggle', 'boogle'];
          }
          return [];
        },
        //보글이 이미지 넣는 것 (조건 맞춰야함)

        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            //print(events.length);
            //final dateStr = DateFormat('yyyy-MM-dd').format(date);
            //day_return = dateStr;
            //print(day_return);
            //String? ref = readdate(day_return);
            //print(ref);
            //String? ref;
            if (kDebugMode) {
              print(events);
            }
            if (events.length > 1) {
              if (kDebugMode) {
                print("만들어짐");
              }
              return Align(
                alignment: const Alignment(0.0, 1.7),
                child: _boggle(),
              );
            } else if (events.isNotEmpty) {
              return Align(
                alignment: const Alignment(0.0, 1.7),
                child: _boogle(),
              );
            }

            /*Future.delayed(Duration(milliseconds: 15000), () {
              if (events.length > 3) {
                print("만들어짐");
                return Align(
                  alignment: Alignment(0.0, 1.7),
                  child: _boggle(),
                );
              } else if (events.length > 1) {
                return Align(
                  alignment: Alignment(0.0, 1.7),
                  child: _boogle(),
                );
              }
            });
            */
            /*Future.delayed(Duration(milliseconds: 5000), () {
              print(dateStr);
              print(ref);
              if (ref == "0") {
                return Align(
                  alignment: Alignment(0.0, 1.7),
                  child: _boggle(),
                );
              } else if (ref == "1") {
                return Align(
                  alignment: Alignment(0.0, 1.7),
                  child: _boogle(),
                );
              }
            });*/
          },
          dowBuilder: (context, day) {
            //캘린더 요일 영어에서 한국어로 변경 및 색 변경
            switch (day.weekday) {
              case 1:
                return const Center(
                  child: Text('월'),
                );
              case 2:
                return const Center(
                  child: Text('화'),
                );
              case 3:
                return const Center(
                  child: Text('수'),
                );
              case 4:
                return const Center(
                  child: Text('목'),
                );
              case 5:
                return const Center(
                  child: Text('금'),
                );
              case 6:
                return const Center(
                  child: Text(
                    '토',
                    style: TextStyle(color: Colors.blue),
                  ),
                );
              case 7:
                return const Center(
                  child: Text(
                    '일',
                    style: TextStyle(color: Colors.red),
                  ),
                );
            }
          },
        ),
        calendarStyle: const CalendarStyle(
          defaultTextStyle: TextStyle(
            color: Color.fromARGB(255, 141, 166, 140),
          ),
          weekendTextStyle:
              TextStyle(color: Color.fromARGB(255, 158, 158, 158)),
          outsideDaysVisible: false,
          todayDecoration: BoxDecoration(
            color: Color.fromARGB(0, 160, 244, 86),
            shape: BoxShape.rectangle,
          ),
          todayTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 4, 84, 14),
            decoration: TextDecoration.underline,
            decorationColor: Color.fromARGB(245, 23, 58, 21),
            //backgroundColor: Color.fromARGB(255, 141, 166, 140)
          ),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
      );

  /*Future<String?> _readdatedata() async {
    final userRef = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.mail)
        .collection("Dates")
        .doc(day_return);
    await userRef.get().then((DocumentSnapshot doc) {
      is_done = doc['isDone'];
      print("출력");
      print(is_done);
    });
  }*/

  void searchDoc() {}

  _delay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Widget _boggle() {
    return SizedBox(
      //margin: EdgeInsets.all(10),
      width: 40,
      height: 40,
      //margin: EdgeInsets.all(10),
      child: Image.asset(
          'assets/images/boggle.png'),
    );
  }

  Widget _boogle() {
    return SizedBox(
      //margin: EdgeInsets.all(10),
      width: 40,
      height: 40,
      //margin: EdgeInsets.all(10),
      child: Image.asset(
          'assets/images/boogle.png'),
    );
  }

  Future _futures() async {
    await Future.delayed(const Duration(seconds: 1));
    return '빌드 시작';
  }

  Future _load() async {
    await Future.delayed(const Duration(seconds: 1));
    return '빌드 시작';
  }
}

class Event {
  String date; // 날짜
  String isDone; //성공 여부
  Event(this.date, this.isDone);

  @override
  String toString() => date;
}

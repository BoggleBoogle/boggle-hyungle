//import 'dart:html';
//
import 'dart:collection';
import 'dart:async';
//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendCompo extends StatefulWidget {
  const FriendCompo({Key? key}) : super(key: key);
  @override
  State<FriendCompo> createState() => _FriendCompoState();
}

class _FriendCompoState extends State<FriendCompo> {
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bulidAppbar(),
      body: Column(children: [cal()]),
    );
  }

  AppBar _bulidAppbar() => AppBar(
        title: const Text("보글부글", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.blue[100],
        centerTitle: true,
        elevation: 0.0,

      );
  Widget cal() {
    return TableCalendar(
      firstDay: DateTime.utc(2015, 1, 1),
      lastDay: DateTime.utc(2050, 12, 31),
      focusedDay: DateTime.now(),
      locale: 'ko-KR',
      //daysOfWeekHeight: 10,
      rowHeight: 60,
      eventLoader: (day) {
        if (day.weekday == DateTime.monday && day.day < DateTime.now().day) {
          return ['hiqq', '2222'];
        } else if (day.day % 4 == 1 && day.day < DateTime.now().day) {
          return ['hiqq', '2222'];
        } else if (day.day < DateTime.now().day) {
          return ['hi'];
        }
        return [];
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.length > 1) {
            return Align(
              alignment: const Alignment(0.0, 3.5),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                    'assets/images/boggle.png'),
              ),
            );
          } else if (events.isNotEmpty) {
            return Align(
              alignment: const Alignment(0.0, 3.5),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                    'assets/images/boogle.png'),
              ),
            );
          }
        },
        dowBuilder: (context, day) {
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
        weekendTextStyle: TextStyle(color: Color.fromARGB(255, 158, 158, 158)),
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
  }
}

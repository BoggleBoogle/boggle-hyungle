import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'setting_page.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:boggleboogle/components/calendar_compo.dart';
import 'my_home_page.dart';
import 'calendar_page.dart';
import 'package:boggleboogle/components/profile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:boggleboogle/model/user.dart';

class User {
  String name;

  User({
    required this.name,
  });
}

class FriendScreen extends StatefulWidget {
  final mail;
  final username;
  final nickname;

  FriendScreen({
    Key? key,
    @required this.mail,
    @required this.username,
    @required this.nickname,
  }) : super(key: key);

  @override
  State<FriendScreen> createState() => _FriendScreen();
}

class _FriendScreen extends State<FriendScreen> {
  String? user_id;
  String? user_name;
  String nick_name = "보글부글";

  _readdata() async {
    String? eid;
    final user = FirebaseAuth.instance.currentUser;

    final userRef =
        await FirebaseFirestore.instance.collection("users").doc(user!.uid);
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
  }

  @override
  void initState() {
    _readdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("친구"),actions: <Widget>[ IconButton(
        //padding: EdgeInsets.only(right: 320.0),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),],),
      body: Column(
        children: [
          const SizedBox(height: 10),
          //ProfileCard(user: me),
          InkWell(
            child: ListTile(
              leading: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  "https://user-images.githubusercontent.com/41139770/180481126-1a6c719c-4a06-46d3-bd6f-d412a2a54028.png",
                ),
              ),
              title: Text(
                widget.nickname,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                widget.username,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                const Text("친구"),
                const SizedBox(width: 6),
                Text("${friends.length}"),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: List.generate(
                friends.length,
                (index) => ProfileCard(user: friends[index]),
              ),
            ),
          )
        ],
      ),
    );
  }
}

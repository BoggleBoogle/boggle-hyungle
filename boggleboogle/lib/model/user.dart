import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class User {
  final String backgroundImage;
  final String name;
  final String intro;

  User({
    required this.backgroundImage,
    required this.name,
    required this.intro,
  });
}

const String _urlPrefix = "assets/images/boogle.png";
User me = User(
  backgroundImage: "https://github.com/alro923.png",
  name: "어현주",
  intro: "설거지 귀찮아,,,",
);

List<User> friends = [
  User(
    backgroundImage:
        "https://thumb.mt.co.kr/06/2019/12/2019122715234999032_2.jpg/dims/optimize/",
    name: "2귤2",
    intro: "어현주 설거지 해~",
  ),
  User(
    backgroundImage:
        "https://i1.sndcdn.com/artworks-UXyE1TAzhPqX8FV6-S0pBgw-t500x500.jpg",
    name: "동구리",
    intro: "25남 여친 구해요",
  ),
  User(
    backgroundImage: "https://pbs.twimg.com/media/CLDr0UpUAAEdZg4.jpg",
    name: "권쿠퍼티노",
    intro: "유니티 60달러~~",
  ),
  User(
    backgroundImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE1rDO8RgV0XpEaKPIYUBEVsbBxIJ02lvAcw&usqp=CAU",
    name: "해적왕 박규태",
    intro: "어~ 현주 청소해~",
  ),
  User(
    backgroundImage:
        "https://www.instagram.com/p/CWLgMcAvNYYMEjC1wCJmCvzbelEEDO5wcelt7I0/?igshid=YmMyMTA2M2Y=",
    name: "우그밋",
    intro: "귀여워",
  ),
  User(
    backgroundImage:
        "https://pbs.twimg.com/media/FWQB-NWagAEp3bS?format=jpg&name=medium",
    name: "고세구",
    intro: "미안하다고 하지말고 사랑한다고 해",
  ),
  User(
    backgroundImage:
        "https://yt3.ggpht.com/v3a75a7gUHU6E-gaJww_k5gkFYI8jthCtAR9ELMaRemymZhIyQLiIIRu4cWOt289DFH1UNkFMA=s900-c-k-c0x00ffffff-no-rj",
    name: "주르르",
    intro: "참을 수 없어욧!",
  ),
];

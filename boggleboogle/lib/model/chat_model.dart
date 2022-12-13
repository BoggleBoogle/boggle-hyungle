class Chat {
  final String image;
  final String title;
  final String content;
  final String time;
  final String count;

  Chat(
      {required this.image,
      required this.title,
      required this.content,
      required this.time,
      required this.count});
}

const String _urlPrefix =
    "https://raw.githubusercontent.com/flutter-coder/ui_images/master/messenger";

List<Chat> chats = [
  Chat(
    image: "${_urlPrefix}_man_1.jpg",
    title: "김인페",
    content: "혹시 프로그래밍 동아리에 관심 있으세요?",
    time: "오후 11:00",
    count: "0",
  ),
  Chat(
    image: "${_urlPrefix}_woman_1.jpg",
    title: "이세종",
    content: "종이 하이",
    time: "오전 09:30",
    count: "1",
  ),
];

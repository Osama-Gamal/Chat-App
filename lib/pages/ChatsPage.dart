import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
late User signedUser;

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedUser = user;
        print(signedUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: const Color.fromARGB(255, 232, 244, 242),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 190, 223, 219),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        SizedBox(
                          width: size.width * 0.73,
                          height: 20,
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 0, 80, 72),
                ),
                const Icon(
                  Icons.more_vert,
                  color: Color.fromARGB(255, 0, 80, 72),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: Color.fromARGB(255, 232, 244, 242), width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.all(0.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StateProfile(imageName: 'face1.jpeg'),
                          StateProfile(imageName: 'face2.jpg'),
                          StateProfile(imageName: 'face3.jpeg'),
                          StateProfile(imageName: 'face4.png'),
                          StateProfile(imageName: 'face5.jpg'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const MessageStreamBuilder(),
          ],
        ),
      ),
    );
  }
}

class StateProfile extends StatelessWidget {
  var imageName;

  StateProfile({
    this.imageName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 0, 80, 72),
            radius: 25,
            child: CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage('assets/images/$imageName'),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "Jasmin Bill",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("user").orderBy("usrTime").snapshots(),
        builder: (context, snapshot) {
          List<MessageLine> messageWiedgets = [];

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final usrImage = message.get("usrImage");
            final usrName = message.get('usrName');
            final currentUser = signedUser.email;

            final messageWidget = MessageLine(
              usrName: usrName,
              usrImage: usrImage,
              isMe: currentUser == usrName,
            );
            messageWiedgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
              ),
              children: messageWiedgets,
            ),
          );
        });
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({this.usrName, this.usrImage, required this.isMe, key})
      : super(key: key);

  final String? usrName;
  final String? usrImage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        height: 100,
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 0, 80, 72),
                  radius: 25,
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/images/face7.jpg'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  usrName!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*
class MessageLine extends StatelessWidget {
  const MessageLine({this.text, this.sender, required this.isMe, key})
      : super(key: key);

  final String? text;
  final String? sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
          Material(
            color: isMe ? Colors.blue[800] : Colors.green,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$text",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
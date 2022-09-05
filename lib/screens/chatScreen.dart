import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/model/DataPasser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'ChatScreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

final _firestore = FirebaseFirestore.instance;
late User signedUser;

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String? messageText = "test";
  final messageTextController = TextEditingController();

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

  /* void getMessages() async {
    final messages = await _firestore.collection("messages").get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }*/

  /*void getMessageStreams() async {
    await for (var snapshot in _firestore.collection("messages").snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
    ;
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 244, 242),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 0, 80, 72),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: 70,
        title: Row(children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/face7.jpg"),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DataPasser.UserName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                DataPasser.UserBio,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () {
                /*_auth.signOut();
                Navigator.pop(context);*/
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStreamBuilder(),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Color.fromARGB(255, 0, 80, 72), width: 2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 45,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 190, 223, 219),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.emoji_emotions,
                          size: 30,
                          color: Color.fromARGB(255, 0, 80, 72),
                        ),
                        Expanded(
                          child: TextField(
                            controller: messageTextController,
                            onChanged: (value) {
                              messageText = value;
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                hintText: "Write Your Message Here...",
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const RotationTransition(
                          turns: AlwaysStoppedAnimation(45 / 360),
                          child: Icon(
                            Icons.attach_file,
                            size: 30,
                            color: Color.fromARGB(255, 0, 80, 72),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.image,
                          size: 30,
                          color: Color.fromARGB(255, 0, 80, 72),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Visibility(
                    visible: messageTextController.text.isEmpty,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 0, 80, 72),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.mic),
                        iconSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: messageTextController.text.isNotEmpty,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 0, 80, 72),
                      child: IconButton(
                        onPressed: () {
                          _firestore
                              .collection('messages')
                              .doc(signedUser.uid + DataPasser.UserID)
                              .set({
                            'text': messageText,
                            'sender': signedUser.email,
                            'conversation': signedUser.uid + DataPasser.UserID,
                            'time': FieldValue.serverTimestamp(),
                          });
                          messageTextController.clear();
                        },
                        icon: const Icon(Icons.send),
                        iconSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('messages')
            .doc(signedUser.uid + DataPasser.UserID)
            .collection('sender')
            .orderBy("time")
            .snapshots(),
        builder: (context, snapshot) {
          List<MessageLine> messageWiedgets = [];

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final messageTxt = message.get("text");
            final messageSender = message.get('sender');
            final currentUser = signedUser.email;

            final messageWidget = MessageLine(
              sender: messageSender,
              text: messageTxt,
              isMe: currentUser == messageSender,
            );
            messageWiedgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWiedgets,
            ),
          );
        });
  }
}

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

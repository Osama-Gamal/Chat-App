import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
late User signedUser;

class _PeoplePageState extends State<PeoplePage> {
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
          const SizedBox(
            height: 2,
          ),
          const Text(
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
        stream: _firestore.collection("user").snapshots(),
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
            final usrBio = message.get('usrBio');
            final currentUser = signedUser.email;

            final messageWidget = MessageLine(
              usrName: usrName,
              usrImage: usrImage,
              usrBio: usrBio,
              isMe: currentUser == usrName,
            );
            messageWiedgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
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
  const MessageLine(
      {this.usrName, this.usrImage, this.usrBio, required this.isMe, key})
      : super(key: key);

  final String? usrName;
  final String? usrImage;
  final String? usrBio;

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: double.infinity,
          height: 70,
          padding: const EdgeInsets.all(8.0),
          //color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 0, 80, 72),
                    radius: 24,
                    child: CircleAvatar(
                      radius: 21,
                      backgroundImage: AssetImage('assets/images/face7.jpg'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        usrName!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        usrBio!,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 0, 80, 72)),
                  ),
                  IconButton(
                    onPressed: (() => {}),
                    icon: const Icon(
                      Icons.more_vert,
                      color: Color.fromARGB(255, 0, 80, 72),
                      size: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

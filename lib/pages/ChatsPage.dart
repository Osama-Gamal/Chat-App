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
                          width: size.width * 0.7,
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
    Future<DocumentSnapshot> getDocument() async {
      return await _firestore
          .collection("user")
          .doc('G2trdbl9WOiPURcPfggX')
          .get();
    }

    Map<String, dynamic>? userMap = {};
    void getUserStreams(ownerID) async {
      await for (var snapshot in _firestore
          .collection("user")
          .where('usrID', isEqualTo: ownerID)
          .snapshots()) {
        for (var user in snapshot.docs) {
          //print('this is data ${user.data()}');
          userMap = user.data();
        }
      }
    }

    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("rooms").orderBy("time").snapshots(),
        builder: (context, snapshot) {
          List<MessageLine> messageWiedgets = [];

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final rooms = snapshot.data!.docs.reversed;
          for (var room in rooms) {
            if (room.get('members').contains(signedUser.uid)) {
              try {
                getUserStreams(room.get('members')[0]);
                final usrImage = userMap!['usrName'];
                final usrName = userMap!['usrName']; //message.get('usrName');
                final usrBio = 'fdsfsdg'; //message.get('usrBio');
                final currentUser = 'fdsf'; //signedUser.email;
                final messageWidget = MessageLine(
                  usrName: usrName,
                  usrImage: "usrImage",
                  usrBio: usrBio,
                  isMe: currentUser == usrName,
                );
                messageWiedgets.add(messageWidget);
                //print('this item specific ' + usrImage.toString());
              } catch (e) {
                print('Error with data : $e');
              }
            }
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
      {required this.usrName,
      required this.usrImage,
      required this.usrBio,
      required this.isMe,
      key})
      : super(key: key);

  final String usrName;
  final String usrImage;
  final String usrBio;

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

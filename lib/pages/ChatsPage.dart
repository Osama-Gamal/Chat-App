import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
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
              height: 180,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StateProfile(imageName: 'face6.jpg'),
                          StateProfile(imageName: 'face7.jpg'),
                          StateProfile(imageName: 'face8.jpeg'),
                          StateProfile(imageName: 'face9.jpeg'),
                          StateProfile(imageName: 'face10.jpg'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
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

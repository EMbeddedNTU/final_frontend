import 'package:flutter/material.dart';

class GestureSettingPage extends StatefulWidget {
  GestureSettingPage({Key? key}) : super(key: key);

  @override
  _GestureSettingPageState createState() => _GestureSettingPageState();
}

class _GestureSettingPageState extends State<GestureSettingPage> {
  List<String> gestureList = ["gesture1", "gesture2", "gesture3"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gestureList.length + 1,
      itemBuilder: (context, index) {
        if (index == gestureList.length) {
          return Center(
            child: Ink(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: IconButton(
                iconSize: 30,
                icon: const Icon(Icons.add),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    gestureList.add("123");
                  });
                },
              ),
            ),
          );
        } else {
          final gesture = gestureList[index];
          return Dismissible(
            key: Key(gesture),
            onDismissed: (direction) {
              setState(() {
                gestureList.removeAt(index);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("手勢： $gesture"),
                  Text("類型： $gesture"),
                  Text("裝置： $gesture"),
                  Text("效果： $gesture")
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

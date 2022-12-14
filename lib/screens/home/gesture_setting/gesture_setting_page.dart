import 'package:flutter/material.dart';

class GestureSettingPage extends StatefulWidget {
  GestureSettingPage({Key? key}) : super(key: key);

  @override
  _GestureSettingPageState createState() => _GestureSettingPageState();
}

class _GestureSettingPageState extends State<GestureSettingPage> {
  List<String> gestureInfoList = [];

  List<String> gesture = ['左', '右', '上', '下', '前', '後'];
  String selectGesture = '左';

  List<String> scope = ['全域', '區域'];
  String selectScope = '全域';

  List<String> agent = ['裝置一', '裝置二'];
  String selectAgent = '裝置一';

  List<String> command = ['開燈', '關燈', '開門', '關門'];
  String selectCommand = '開燈';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gestureInfoList.length + 1,
      itemBuilder: (context, index) {
        return (index == gestureInfoList.length)
            ? addButton()
            : gestureCard(index);
      },
    );
  }

  Widget addGesture(BuildContext context, StateSetter set) {
    void setGesture(value) {
      set(() {
        selectGesture = value;
      });
    }

    void setScope(value) {
      set(() {
        selectScope = value;
      });
    }

    void setAgent(value) {
      set(() {
        selectAgent = value;
      });
    }

    void setCommand(value) {
      set(() {
        selectCommand = value;
      });
    }

    return Column(mainAxisSize: MainAxisSize.min, children: [
      singleProperty(context, setGesture, "手勢", gesture, selectGesture),
      singleProperty(context, setScope, "類型", scope, selectScope),
      singleProperty(context, setAgent, "裝置", agent, selectAgent),
      singleProperty(context, setCommand, "效果", command, selectCommand),
      const SizedBox(height: 10),
      ElevatedButton(
        onPressed: () {
          setState(() {
            gestureInfoList.add("test");
          });
          Navigator.of(context).pop();
        },
        child: const Text("確認"),
      )
    ]);
  }

  Widget singleProperty(BuildContext context, void Function(String) setState,
      String title, List<String> list, String selectedValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(title),
        DropdownButton(
          value: selectedValue,
          items: list
              .map((item) => DropdownMenuItem(
                    value: item,
                    child:
                        SizedBox(width: 100, child: Center(child: Text(item))),
                  ))
              .toList(),
          onChanged: (String? value) {
            if (value is String) {
              setState(value);
            }
          },
        )
      ],
    );
  }

  Widget addButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
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
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        title: const Center(child: Text("新增手勢")),
                        content: addGesture(context, setState),
                      );
                    });
                  });
            },
          ),
        ),
      ),
    );
  }

  Widget gestureCard(int index) {
    final gesture = gestureInfoList[index];
    return Dismissible(
      key: Key(gesture),
      onDismissed: (direction) {
        setState(() {
          gestureInfoList.removeAt(index);
        });
      },
      child: Container(
        margin: const EdgeInsets.all(5),
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
}

import 'package:final_frontend/data/model/agent_info.dart';
import 'package:final_frontend/screens/home/agent_setting/agent_setting_model.dart';
import 'package:final_frontend/screens/home/agent_setting/components/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgentPage extends StatelessWidget {
  const AgentPage(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final List<AgentInfo> agentProfiles =
        context.watch<AgentSettingModel>().agentProfiles;
    final agentInfo = agentProfiles[index];

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFD5E4E5),
      appBar: buildAppBar(context, agentInfo.name),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAgentImageView(width, height),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildInfoContainer(context, agentInfo),
                  const SizedBox(height: 20),
                  buildTypeInfoContainer(context, agentInfo),
                  const SizedBox(height: 20),
                  buildCommandButtons(context, agentInfo.id),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context, String title) {
    return AppBar(
      title: Text(title,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      backgroundColor: const Color(0xFFEB6440),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildAgentImageView(double width, double height) {
    return Container(
      height: height * 0.20,
      width: width,
      child: Column(
        children: [
          //TODO:
          // SizedBox(
          //   height: height * 0.32,
          //   child: FittedBox(
          //     fit: BoxFit.none,
          //     child: Image.asset(
          //       product.image,
          //       scale: 3,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildInfoContainer(BuildContext context, AgentInfo agentInfo) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildName(context, agentInfo.name),
          const SizedBox(height: 10),
          buildLocationText(context, agentInfo.location),
          const SizedBox(height: 10),
          buildEditButton(context),
        ],
      ),
    );
  }

  Text buildName(BuildContext context, String name) {
    return Text(
      '裝置名稱： $name',
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget buildLocationText(BuildContext context, String location) {
    return Column(children: [
      Text(
        '裝置位置：$location',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
    ]);
  }

  Container buildTypeInfoContainer(BuildContext context, AgentInfo agentInfo) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: buildTypeListText(context, agentInfo.typeList),
    );
  }

  Widget buildTypeListText(BuildContext context, List<String> typeList) {
    final List<Widget> listWidget = typeList
        .map((e) => Text('    $e', style: const TextStyle(fontSize: 20)))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '裝置的狀態：',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...listWidget,
      ],
    );
  }

  Widget buildCommandButtons(BuildContext context, int agentId) {
    final commandOptions = context.read<AgentSettingModel>().commandOptions;

    const blockHeight = 150.0;

    return Container(
      width: double.infinity,
      height: blockHeight,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: commandOptions.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFEB6440),
              child: InkWell(
                child: Container(
                  width: blockHeight - 36 - 16,
                  child: Center(
                    child: Text(
                      commandOptions[index].name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () {
                  context
                      .read<AgentSettingModel>()
                      .makeStateCommandList(agentId, commandOptions[index].id);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildEditButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            final notifier =
                Provider.of<AgentSettingModel>(context, listen: false);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ChangeNotifierProvider<AgentSettingModel>.value(
                  value: notifier,
                  builder: (BuildContext context, _) {
                    return AlertDialog(
                      title: const Center(
                          child: Text("更改",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold))),
                      content: buildEditProfilePopup(context),
                    );
                  },
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12),
            backgroundColor: const Color(0xFF4A7174), // <-- Button color
            foregroundColor: const Color(0xFFEB6440), // <-- Splash color
          ),
          child: const Icon(Icons.edit, color: Colors.white),
        ),
      ],
    );
  }

  Widget buildEditProfilePopup(BuildContext context) {
    final List<AgentInfo> agentProfiles =
        context.watch<AgentSettingModel>().agentProfiles;
    final agentInfo = agentProfiles[index];
    double wid = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(height: 10, width: wid - 30.0),
        TextFieldWidget(
            label: "名稱",
            text: agentInfo.name,
            onChanged: context.read<AgentSettingModel>().setAgentName),
        const SizedBox(height: 20),
        TextFieldWidget(
            label: "位置",
            text: agentInfo.location,
            onChanged: context.read<AgentSettingModel>().setAgentLocation),
        const SizedBox(height: 30),
        buildSaveButton(context, agentInfo.id)
      ]),
    );
  }

  Widget buildSaveButton(BuildContext context, int agentId) {
    final buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF4A7174),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      minimumSize: const Size(100, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
    return Wrap(alignment: WrapAlignment.center, spacing: 30, children: [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: buttonStyle,
        child: const Text("取消"),
      ),
      ElevatedButton(
        onPressed: () {
          context.read<AgentSettingModel>().editAgentProfile(agentId);
          Navigator.of(context).pop();
        },
        style: buttonStyle,
        child: const Text("確認"),
      )
    ]);
  }
}

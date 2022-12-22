import 'package:final_frontend/data/model/agent_info.dart';
import 'package:final_frontend/data/model/device.dart';
import 'package:final_frontend/screens/home/agent_setting/agent_setting_model.dart';
import 'package:final_frontend/screens/home/agent_setting/components/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgentPage extends StatelessWidget {
  AgentPage(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final List<AgentInfo> agentProfiles =
        context.watch<AgentSettingModel>().agentProfiles;
    final agentInfo = agentProfiles[index];

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProductPageView(width, height),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildName(context, agentInfo.name),
                    const SizedBox(height: 10),
                    buildLocationText(context, agentInfo.location),
                    const SizedBox(height: 30),
                    buildEditButton(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
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

  Widget buildProductPageView(double width, double height) {
    return Container(
      height: height * 0.42,
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

  Text buildName(BuildContext context, String name) {
    return Text(
      name,
      style: Theme.of(context).textTheme.headline2,
    );
  }

  Widget buildLocationText(BuildContext context, String location) {
    return Column(children: [
      Text(
        location,
        style: Theme.of(context).textTheme.headline4,
      ),
      const SizedBox(height: 10),
      // Text(product.about)
    ]);
  }

  Widget buildSaveButton(BuildContext context, int agentId) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("取消"),
      ),
      const SizedBox(width: 30),
      ElevatedButton(
        onPressed: () {
          context.read<AgentSettingModel>().editAgentProfile(agentId);
          Navigator.of(context).pop();
        },
        child: const Text("確認"),
      )
    ]);
  }

  Widget buildEditButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final notifier = Provider.of<AgentSettingModel>(context, listen: false);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ChangeNotifierProvider<AgentSettingModel>.value(
              value: notifier,
              builder: (BuildContext context, _) {
                return AlertDialog(
                  title: const Center(child: Text("更改")),
                  content: buildEditProfilePopup(context),
                );
              },
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        backgroundColor: Colors.blue, // <-- Button color
        foregroundColor: Colors.red, // <-- Splash color
      ),
      child: const Icon(Icons.edit, color: Colors.white),
    );
  }

  Widget buildEditProfilePopup(BuildContext context) {
    final List<AgentInfo> agentProfiles =
        context.watch<AgentSettingModel>().agentProfiles;
    final agentInfo = agentProfiles[index];

    return Column(mainAxisSize: MainAxisSize.min, children: [
      const SizedBox(height: 10),
      TextFieldWidget(
          label: "名稱",
          text: agentInfo.name,
          onChanged: context.read<AgentSettingModel>().setAgentName),
      TextFieldWidget(
          label: "位置",
          text: agentInfo.location,
          onChanged: context.read<AgentSettingModel>().setAgentLocation),
      buildSaveButton(context, agentInfo.id)
    ]);
  }
}

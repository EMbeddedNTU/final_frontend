import 'package:final_frontend/data/client/agent_service.dart';
import 'package:final_frontend/data/client/notification_service.dart';
import 'package:final_frontend/data/model/agent_info.dart';
import 'package:final_frontend/screens/home/agent_setting/components/agent_item_view.dart';
import 'package:final_frontend/components/text_box.dart';
import 'package:final_frontend/screens/home/agent_setting/agent/agent_detail.dart';
import 'package:final_frontend/screens/home/agent_setting/agent_setting_model.dart';
import 'package:final_frontend/screens/home/components/notification.dart';
import 'package:final_frontend/screens/home/notification/notification_page.dart';
import 'package:final_frontend/screens/util/base_state_less_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class AgentSettingPage extends BaseStatelessWidget<AgentSettingModel> {
  const AgentSettingPage({Key? key}) : super(key: key);

  @override
  AgentSettingModel createProvider(BuildContext context) {
    final AgentService agentService = GetIt.instance<AgentService>();
    final NotificationService notificationService =
        GetIt.instance<NotificationService>();
    return AgentSettingModel(agentService, notificationService);
  }

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.clear_all_rounded,
                      size: 28,
                    ))),
            buildNotificationButton(context)
          ],
        ),
      ),
      body: buildMain(context),
    );
  }

  Widget buildNotificationButton(BuildContext context) {
    final int notificationNum =
        context.watch<AgentSettingModel>().notifications.length;
    return NotificationBox(
      number: notificationNum,
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NotificationPage()));
      },
    );
  }

  Widget buildMain(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: const Text(
              "Find Agent",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          buildSearchBox(context),
          const SizedBox(height: 45),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: const Text(
              "Your Agents",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: buildAgentProfileList(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Container buildSearchBox(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: CustomTextBox(
        onSubmitted: context.read<AgentSettingModel>().searchAgent,
        hint: "Search",
        prefix: const Icon(Icons.search, color: Colors.black),
        suffix: const Icon(Icons.filter_list_outlined, color: Colors.black),
      ),
    );
  }

  Widget buildAgentProfileList(BuildContext context) {
    final List<AgentInfo> agentProfiles =
        context.watch<AgentSettingModel>().filterAgentProfiles;
    return Column(
      children: List.generate(
        agentProfiles.length,
        (index) => AgentItemView(
          agentInfo: agentProfiles[index],
          onTap: () async {
            final notifier =
                Provider.of<AgentSettingModel>(context, listen: false);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<AgentSettingModel>.value(
                        value: notifier, child: AgentPage(index)),
              ),
            );
          },
        ),
      ),
    );
  }
}

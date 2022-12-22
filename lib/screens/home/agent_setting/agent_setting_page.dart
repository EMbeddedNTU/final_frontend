import 'package:final_frontend/data/client/agent_service.dart';
import 'package:final_frontend/data/model/agent_info.dart';
import 'package:final_frontend/screens/home/agent_setting/components/agent_item_view.dart';
import 'package:final_frontend/components/text_box.dart';
import 'package:final_frontend/screens/home/agent_setting/agent/agent_detail.dart';
import 'package:final_frontend/screens/home/agent_setting/agent_setting_model.dart';
import 'package:final_frontend/screens/home/components/notification.dart';
import 'package:final_frontend/screens/util/base_state_less_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class AgentSettingPage extends BaseStatelessWidget<AgentSettingModel> {
  const AgentSettingPage({Key? key}) : super(key: key);

  @override
  AgentSettingModel createProvider(BuildContext context) {
    final AgentService agentService = GetIt.instance<AgentService>();
    return AgentSettingModel(agentService);
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
            const NotificationBox(
              number: 1,
            )
          ],
        ),
      ),
      body: buildMain(context),
    );
  }

  Widget buildMain(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: const Text(
              "Find Agent",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: CustomTextBox(
                  hint: "Search",
                  prefix: const Icon(Icons.search, color: Colors.black),
                  suffix: const Icon(Icons.filter_list_outlined,
                      color: Colors.black))),
          const SizedBox(
            height: 25,
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: const Text(
              "Your Agents",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: buildAgentProfileList(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildAgentProfileList(BuildContext context) {
    final List<AgentInfo> agentProfiles =
        context.watch<AgentSettingModel>().agentProfiles;
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

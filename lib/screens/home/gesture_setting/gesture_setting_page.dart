import 'package:final_frontend/data/client/gesture_service.dart';
import 'package:final_frontend/data/model/effect_type.dart';
import 'package:final_frontend/data/model/gesture_setting.dart';
import 'package:final_frontend/data/model/gesture_type.dart';
import 'package:final_frontend/screens/home/gesture_setting/gesture_setting_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class GestureSettingPage extends StatefulWidget {
  const GestureSettingPage({Key? key}) : super(key: key);

  @override
  GestureSettingPageState createState() => GestureSettingPageState();
}

class GestureSettingPageState extends State<GestureSettingPage> {
  List<String> gesture = ['左', '右', '上', '下', '前', '後'];
  List<String> scope = ['全域', '區域'];

  GestureSettingModel createProvider(BuildContext context) {
    final GestureService gestureService = GetIt.instance<GestureService>();
    return GestureSettingModel(gestureService);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GestureSettingModel>(
      create: (context) => createProvider(context),
      builder: (context, _) {
        final List<GestureSetting> gestureSettings =
            context.select<GestureSettingModel, List<GestureSetting>>(
                (GestureSettingModel model) => model.gestureSettings);

        return Column(children: [
          const Align(
              child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("手勢設定",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          )),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: gestureSettings.length,
              itemBuilder: (context, index) {
                return buildGestureCard(context, gestureSettings[index], index);
              },
            ),
          ),
          buildAddButton(context)
        ]);
      },
    );
  }

  Widget buildAddGesturePopup(BuildContext context) {
    final selectScope = context.watch<GestureSettingModel>().selectScope;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        buildGestureSelection(context, GestureType.values),
        buildScopeSelection(context, EffectType.values),
        selectScope == EffectType.local
            ? const SizedBox.shrink()
            : buildAgentSelection(context),
        buildEffectSelection(context),
        const SizedBox(height: 30),
        buildSubmitButtons(context),
      ]),
    );
  }

  Widget buildSubmitButtons(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.cyan,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      minimumSize: const Size(100, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
    return Wrap(alignment: WrapAlignment.center, spacing: 50, children: [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: buttonStyle,
        child: const Text("取消"),
      ),
      ElevatedButton(
        onPressed: () {
          context.read<GestureSettingModel>().addGesture();
          Navigator.of(context).pop();
        },
        style: buttonStyle,
        child: const Text("確認"),
      )
    ]);
  }

  Widget buildGestureSelection(BuildContext context, List<GestureType> list) {
    final selectedGesture = context.watch<GestureSettingModel>().selectGesture;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text("手勢"),
        const SizedBox(width: 30),
        DropdownButton(
          value: selectedGesture,
          items: list
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: SizedBox(
                        width: 100, child: Center(child: Text(item.getText()))),
                  ))
              .toList(),
          onChanged: (GestureType? value) {
            if (value != null) {
              context.read<GestureSettingModel>().setGesture(value);
            }
          },
        )
      ],
    );
  }

  Widget buildScopeSelection(BuildContext context, List<EffectType> list) {
    final selectedEffect = context.watch<GestureSettingModel>().selectScope;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text("類型"),
        const SizedBox(width: 30),
        DropdownButton(
          value: selectedEffect,
          items: list
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: SizedBox(
                        width: 100, child: Center(child: Text(item.getText()))),
                  ))
              .toList(),
          onChanged: (EffectType? value) {
            if (value != null) {
              context.read<GestureSettingModel>().setScope(value);
            }
          },
        )
      ],
    );
  }

  Widget buildAgentSelection(BuildContext context) {
    final agents =
        context.watch<GestureSettingModel>().gestureSettingOption.agentInfoList;
    final selectAgent = context.watch<GestureSettingModel>().selectAgent;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text("裝置"),
        const SizedBox(width: 30),
        DropdownButton(
          value: selectAgent,
          items: agents
              .map((item) => DropdownMenuItem(
                    key: UniqueKey(),
                    value: item,
                    child: SizedBox(
                        width: 100, child: Center(child: Text(item.name))),
                  ))
              .toList(),
          onChanged: context.read<GestureSettingModel>().setAgent,
        )
      ],
    );
  }

  Widget buildEffectSelection(BuildContext context) {
    final stateCommandOptions =
        context.watch<GestureSettingModel>().stateCommandOptions;
    final int selectStateCommandId =
        context.watch<GestureSettingModel>().selectStateCommandId;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text("效果"),
        const SizedBox(width: 30),
        DropdownButton(
          value: selectStateCommandId,
          items: stateCommandOptions
              .map((item) => DropdownMenuItem(
                    value: item.id,
                    child: SizedBox(
                        width: 100, child: Center(child: Text(item.name))),
                  ))
              .toList(),
          onChanged: (int? value) {
            if (value != null) {
              context.read<GestureSettingModel>().setCommand(value);
            }
          },
        )
      ],
    );
  }

  Widget buildAddButton(BuildContext context) {
    return Container(
      key: UniqueKey(),
      margin: const EdgeInsets.only(top: 10, bottom: 35),
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
                final notifier =
                    Provider.of<GestureSettingModel>(context, listen: false);
                context.read<GestureSettingModel>().refreshPopupOption();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ChangeNotifierProvider<GestureSettingModel>.value(
                      value: notifier,
                      builder: (context, _) {
                        return AlertDialog(
                          title: const Center(
                              child: Text("新增手勢",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))),
                          content: buildAddGesturePopup(context),
                        );
                      },
                    );
                  },
                );
              }),
        ),
      ),
    );
  }

  Widget buildGestureCard(
      BuildContext context, GestureSetting setting, int index) {
    final agentName = setting.effectType == EffectType.local
        ? "當前最近的裝置"
        : setting.agentTargetName;

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        context
            .read<GestureSettingModel>()
            .deleteGesture(setting.gestureType, setting.effectType, null);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            Text("手勢： ${setting.gestureType.getText()}"),
            Text("類型： ${setting.effectType.getText()}"),
            Text("裝置： $agentName"),
            Text("效果： ${setting.stateCommandName}")
          ],
        ),
      ),
    );
  }
}

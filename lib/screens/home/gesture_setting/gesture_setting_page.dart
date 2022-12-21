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
  List<String> agent = ['裝置一', '裝置二'];

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

        return ListView.builder(
          itemCount: gestureSettings.length + 1,
          itemBuilder: (context, index) {
            return (index == gestureSettings.length)
                ? buildAddButton(context)
                : buildGestureCard(context, gestureSettings[index], index);
          },
        );
      },
    );
  }

  Widget buildAddGesturePopup(BuildContext context) {
    final selectScope = context.watch<GestureSettingModel>().selectScope;
    final selectAgent = context.watch<GestureSettingModel>().selectAgent;
    final selectStateCommandId =
        context.watch<GestureSettingModel>().selectStateCommandId;

    final stateCommandOptions =
        (context.watch<GestureSettingModel>().stateCommandOptions)
            .map((e) => e.id)
            .toList();

    return Column(mainAxisSize: MainAxisSize.min, children: [
      buildGestureSelection(context, GestureType.values),
      buildSingleProperty(context, context.read<GestureSettingModel>().setScope,
          "類型", EffectType.values, selectScope),
      buildSingleProperty(context, context.read<GestureSettingModel>().setAgent,
          "裝置", agent, selectAgent),
      buildSingleProperty(
          context,
          context.read<GestureSettingModel>().setCommand,
          "效果",
          stateCommandOptions,
          selectStateCommandId),
      const SizedBox(height: 10),
      Row(children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("取消"),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<GestureSettingModel>().addGesture();
            Navigator.of(context).pop();
          },
          child: const Text("確認"),
        )
      ]),
    ]);
  }

  Widget buildGestureSelection(BuildContext context, List<GestureType> list) {
    final selectedGesture = context.watch<GestureSettingModel>().selectGesture;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text("手勢"),
        DropdownButton(
          value: selectedGesture,
          items: list
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: SizedBox(
                        width: 100,
                        child: Center(child: Text(item.toString()))),
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

  Widget buildSingleProperty<T>(BuildContext context, void Function(T) setState,
      String title, List<T> list, T selectedValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(title),
        DropdownButton(
          value: selectedValue,
          items: list
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: SizedBox(
                        width: 100,
                        child: Center(child: Text(item.toString()))),
                  ))
              .toList(),
          onChanged: (T? value) {
            if (value is T) {
              setState(value);
            }
          },
        )
      ],
    );
  }

  Widget buildAddButton(BuildContext context) {
    return Container(
      key: UniqueKey(),
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
                final notifier =
                    Provider.of<GestureSettingModel>(context, listen: false);
                context.read<GestureSettingModel>().getGestureOptions();
                context.read<GestureSettingModel>().getStateCommandOptions();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ChangeNotifierProvider<GestureSettingModel>.value(
                      value: notifier,
                      builder: (context, _) {
                        return AlertDialog(
                          title: const Center(child: Text("新增手勢")),
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
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        context
            .read<GestureSettingModel>()
            .deleteGesture(setting.gestureType, setting.effectType, 0); //TODO:
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
            Text("手勢： ${setting.gestureType}"),
            Text("類型： ${setting.effectType}"),
            Text("裝置： ${setting.agentTriggerName}"),
            Text("效果： ${setting.stateCommandName}")
          ],
        ),
      ),
    );
  }
}

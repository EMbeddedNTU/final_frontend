import 'dart:developer';

import 'package:final_frontend/data/client/gesture_service.dart';
import 'package:final_frontend/data/model/agent_info.dart';
import 'package:final_frontend/data/model/effect_type.dart';
import 'package:final_frontend/data/model/gesture_setting_option.dart';
import 'package:final_frontend/data/model/gesture_state_command_option.dart';
import 'package:final_frontend/data/model/gesture_setting.dart';
import 'package:final_frontend/data/model/gesture_type.dart';
import 'package:final_frontend/screens/util/base_model.dart';

class GestureSettingModel extends BaseModel {
  GestureSettingModel(this._gestureService) {
    getGestureSettings();
  }

  final GestureService _gestureService;

  List<GestureSetting> gestureSettings = [];

  GestureSettingOption gestureSettingOption = GestureSettingOption(
      gestureTypeList: [], effectTypeList: [], agentInfoList: []);

  List<StateCommandOption> stateCommandOptions = [];

  GestureType selectGesture = GestureType.left;
  EffectType selectScope = EffectType.local;
  AgentInfo? selectAgent;
  int selectStateCommandId = 0;

  void getGestureSettings() {
    subscribe<List<GestureSetting>>(
      _gestureService.getGestureSettingList(),
      (response) {
        gestureSettings = response;
        notifyListeners();
      },
    );
  }

  void getGestureOptions() {
    subscribe<GestureSettingOption?>(
      _gestureService.getGesutreSettingOption(),
      (response) {
        if (response != null) {
          gestureSettingOption = response;
          notifyListeners();
        }
      },
    );
  }

  void getStateCommandOptions() {
    subscribe<List<StateCommandOption>>(
      _gestureService.getStateCommandOptionList(),
      (response) {
        stateCommandOptions = response;
        notifyListeners();
      },
    );
  }

  void refreshPopupOption() {
    selectAgent = null;
    getGestureOptions();
    getStateCommandOptions();
    log("refresh");
  }

  void addGesture() {
    if (selectAgent != null || selectScope == EffectType.local) {
      subscribe<bool>(
        _gestureService.addGesture(
            selectGesture,
            selectScope,
            selectStateCommandId,
            selectAgent?.id,
            selectAgent?.id,
            null), //TODO:
        (response) {
          print("add gesture");
          print(response);
          getGestureSettings();
        },
      );
    } else {
      log("no selected agent");
    }
  }

  void deleteGesture(
      GestureType gestureType, EffectType effectType, int? triggerAgentId) {
    subscribe<bool>(
      _gestureService.deleteGesture(gestureType, effectType, triggerAgentId),
      (response) {
        print(response);
        getGestureSettings();
      },
    );
  }

  void setGesture(GestureType value) {
    selectGesture = value;
    notifyListeners();
  }

  void setScope(EffectType value) {
    selectScope = value;
    notifyListeners();
  }

  void setAgent(AgentInfo? value) {
    if (value != null) {
      selectAgent = value;
      notifyListeners();
    }
  }

  void setCommand(int value) {
    selectStateCommandId = value;
    notifyListeners();
  }
}

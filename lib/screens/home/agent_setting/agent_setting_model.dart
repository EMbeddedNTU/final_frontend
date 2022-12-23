import 'dart:async';
import 'dart:developer';

import 'package:final_frontend/data/client/agent_service.dart';
import 'package:final_frontend/data/client/notification_service.dart';
import 'package:final_frontend/data/model/agent_info.dart';
import 'package:final_frontend/data/model/gesture_state_command_option.dart';
import 'package:final_frontend/data/model/notification.dart';
import 'package:final_frontend/screens/util/base_model.dart';

class AgentSettingModel extends BaseModel {
  AgentSettingModel(this._agentService, this._notificationService) {
    getAgentProfiles();
    timer =
        Timer.periodic(const Duration(seconds: 10), (_) => _getNotifications());
  }

  final AgentService _agentService;
  final NotificationService _notificationService;
  List<NotificationData> notifications = [];

  late final Timer timer;

  List<AgentInfo> agentProfiles = [];
  List<AgentInfo> filterAgentProfiles = [];

  // For currently selected agent
  String? nameInput;
  String? locationInput;
  List<StateCommandOption> commandOptions = [];

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void _getNotifications() {
    subscribe<List<NotificationData>>(
      _notificationService.getNotifications(),
      (response) {
        notifications = response;
        if (notifications.length != response.length) {
          notifyListeners();
        }
      },
    );
  }

  void searchAgent(String value) {
    if (value != "") {
      filterAgentProfiles =
          agentProfiles.where((i) => i.name.contains(value)).toList();
    } else {
      filterAgentProfiles = List.from(agentProfiles);
    }
    notifyListeners();
  }

  void getAgentProfiles() {
    subscribe<List<AgentInfo>>(
      _agentService.getAgentProfiles(),
      (response) {
        agentProfiles = response;
        filterAgentProfiles = List.from(agentProfiles);
        notifyListeners();
      },
    );
  }

  void editAgentProfile(int id) {
    print(nameInput);
    print(locationInput);
    subscribe<bool>(
      _agentService.editAgentProfile(id, nameInput, locationInput),
      (response) {
        log(response.toString());
        getAgentProfiles();
      },
    );
  }

  void setAgentName(String value) {
    nameInput = value;
    notifyListeners();
  }

  void setAgentLocation(String value) {
    locationInput = value;
    notifyListeners();
  }

  void getStateCommandList(int agentId) {
    subscribe<List<StateCommandOption>>(
      _agentService.getStateCommandOptionList(agentId),
      (response) {
        commandOptions = response;
      },
    );
  }

  void makeStateCommandList(int agentId, int stateCommandId) {
    subscribe<bool>(
      _agentService.makeStateCommand(agentId, stateCommandId),
      (response) {
        log(response.toString());
        getAgentProfiles();
      },
    );
  }
}

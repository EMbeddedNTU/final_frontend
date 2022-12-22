import 'dart:async';

import 'package:final_frontend/data/client/agent_service.dart';
import 'package:final_frontend/data/client/notification_service.dart';
import 'package:final_frontend/data/model/agent_info.dart';
import 'package:final_frontend/data/model/notification.dart';
import 'package:final_frontend/screens/util/base_model.dart';

class AgentSettingModel extends BaseModel {
  AgentSettingModel(this._agentService, this._notificationService) {
    getAgentProfiles();
    Timer.periodic(const Duration(seconds: 30), (_) => _getNotifications());
  }

  final AgentService _agentService;
  final NotificationService _notificationService;
  List<NotificationData> notifications = [];

  List<AgentInfo> agentProfiles = [];
  List<AgentInfo> filterAgentProfiles = [];

  String? nameInput;
  String? locationInput;

  void _getNotifications() {
    subscribe<List<NotificationData>>(
      _notificationService.getNotifications(),
      (response) {
        notifications = response;
        notifyListeners();
      },
    );
  }

  void getAgentProfiles() {
    subscribe<List<AgentInfo>>(
      _agentService.getAgentProfiles(),
      (response) {
        agentProfiles = response;
        notifyListeners();
      },
    );
  }

  void editAgentProfile(int id) {
    print(id);
    print(nameInput);
    print(locationInput);
    subscribe<bool>(
      _agentService.editAgentProfile(id, nameInput, locationInput),
      (response) {
        print(response);
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
}

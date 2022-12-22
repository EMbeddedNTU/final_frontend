import 'package:final_frontend/data/client/agent_service.dart';
import 'package:final_frontend/data/model/agent_info.dart';
import 'package:final_frontend/screens/util/base_model.dart';

class AgentSettingModel extends BaseModel {
  AgentSettingModel(this._agentService) {
    getAgentProfiles();
  }

  final AgentService _agentService;

  List<AgentInfo> agentProfiles = [];

  String? name_input = null;
  String? location_input = null;

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
    print(name_input);
    print(location_input);
    subscribe<bool>(
      _agentService.editAgentProfile(id, name_input, location_input),
      (response) {
        print(response);
        getAgentProfiles();
      },
    );
  }

  void setAgentName(String value) {
    name_input = value;
    notifyListeners();
  }

  void setAgentLocation(String value) {
    location_input = value;
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:final_frontend/data/model/agent_info.dart';
import 'package:final_frontend/data/model/gesture_state_command_option.dart';
import 'package:http/http.dart' as http;

class AgentService {
  final String _baseUrl;

  AgentService({required String url}) : _baseUrl = url;

  Future<List<AgentInfo>> getAgentProfiles() async {
    const urlPart = "phone/agentSetting/agentProfiles";
    final url = Uri.parse('$_baseUrl$urlPart');
    print(url);
    try {
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        List options = jsonDecode(response.body);
        return options.map((opt) => AgentInfo.fromMap(opt)).toList();
      } else {
        // TODO:
        throw Exception();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> editAgentProfile(int id, String? name, String? location) async {
    const urlPart = "phone/agentSetting/changeAgentProfile";
    Map<String, String> body = {
      "id": id.toString(),
    };

    if (name != null) {
      body["name"] = name.toString();
    }
    if (location != null) {
      body["location"] = location.toString();
    }

    final url = Uri.parse('$_baseUrl$urlPart');
    final response = await http.post(url, body: body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      print(response);
      return json.decode(response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<StateCommandOption>> getStateCommandOptionList(
      int agentId) async {
    final urlPart = 'phone/stateCommandOption/$agentId';
    final url = Uri.parse('$_baseUrl$urlPart');
    print(url);
    try {
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        List options = jsonDecode(response.body);
        return options.map((opt) => StateCommandOption.fromMap(opt)).toList();
      } else {
        // TODO:
        throw Exception();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> makeStateCommand(int agentId, int stateCommandId) async {
    const urlPart = 'phone/command/makeCommand';
    final url = Uri.parse('$_baseUrl$urlPart');
    Map<String, String> body = {
      "agentId": agentId.toString(),
      "stateCommandId": stateCommandId.toString(),
    };

    final response = await http.post(url, body: body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      print(response);
      return json.decode(response.body);
    } else {
      throw Exception();
    }
  }
}

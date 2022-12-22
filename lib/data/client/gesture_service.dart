import 'dart:convert';

import 'package:final_frontend/data/model/effect_type.dart';
import 'package:final_frontend/data/model/gesture_setting_option.dart';
import 'package:final_frontend/data/model/gesture_state_command_option.dart';
import 'package:final_frontend/data/model/gesture_setting.dart';
import 'package:final_frontend/data/model/gesture_type.dart';
import 'package:http/http.dart' as http;

class GestureService {
  final String _baseUrl;

  GestureService({required String url}) : _baseUrl = url;

  Future<List<GestureSetting>> getGestureSettingList() async {
    const urlPart = "phone/gestureList";
    final url = Uri.parse('$_baseUrl$urlPart');
    print(url);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        List settings = json.decode(response.body);
        return settings
            .map((setting) => GestureSetting.fromMap(setting))
            .toList();
      } else {
        // TODO:
        throw Exception();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<GestureSettingOption?> getGesutreSettingOption() async {
    const urlPart = "phone/gestureSettingOption";
    final url = Uri.parse('$_baseUrl$urlPart');
    print(url);
    try {
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return GestureSettingOption.fromJson(response.body);
      } else {
        // TODO:
        throw Exception();
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<StateCommandOption>> getStateCommandOptionList() async {
    const urlPart = "phone/stateCommandOption";
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

  Future<bool> addGesture(
    GestureType gestureType,
    EffectType effectType,
    int stateCommandId,
    int? stateCommandAgentId,
    int? targetAgentId,
    int? triggerAgentId,
  ) async {
    const urlPart = "phone/addGesture";
    Map<String, String> body = {
      "gestureType": gestureType.index.toString(),
      "effectType": effectType.index.toString(),
      "stateCommandId": stateCommandId.toString(),
    };

    if (stateCommandAgentId != null) {
      body["stateCommandAgentId"] = stateCommandAgentId.toString();
    }
    if (triggerAgentId != null) {
      body["triggerAgentId"] = triggerAgentId.toString();
    }
    if (targetAgentId != null) {
      body["targetAgentId"] = targetAgentId.toString();
    }

    final url = Uri.parse('$_baseUrl$urlPart');
    final response = await http.post(url, body: body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      print(response);
      return json.decode(response.body);
    } else {
      final body = response.body;
      // TODO:
      if (body.contains("UserDisabled")) {
        throw Exception();
      } else {
        throw Exception();
      }
    }
  }

  Future<bool> deleteGesture(
    GestureType gestureType,
    EffectType effectType,
    int? triggerAgentId,
  ) async {
    print("here");
    const urlPart = "phone/deleteGesture";
    Map<String, String> body = {
      "gestureType": gestureType.index.toString(),
      "effectType": effectType.index.toString(),
    };

    if (triggerAgentId != null) {
      body["triggerAgentId"] = triggerAgentId.toString();
    }

    final url = Uri.parse('$_baseUrl$urlPart');
    final response = await http.post(url, body: body);

    print(response.statusCode);

    if (response.statusCode == 201) {
      print(response);
      return json.decode(response.body);
    } else {
      final body = response.body;
      // TODO:
      if (body.contains("UserDisabled")) {
        throw Exception();
      } else {
        throw Exception();
      }
    }
  }
}

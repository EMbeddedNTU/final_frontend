import 'dart:convert';

import 'package:final_frontend/data/model/agent_info.dart';

class GestureSettingOption {
  GestureSettingOption(
      {required this.gestureTypeList,
      required this.effectTypeList,
      required this.agentInfoList});

  List<String> gestureTypeList;

  List<String> effectTypeList;

  List<AgentInfo> agentInfoList;

  Map<String, dynamic> toMap() => {
        "gestureTypeList": gestureTypeList,
        "effectTypeList": effectTypeList,
        "agentInfoList": agentInfoList,
      };

  factory GestureSettingOption.fromMap(Map<String, dynamic> map) {
    return GestureSettingOption(
      gestureTypeList: List.from(map['gestureTypeList']),
      effectTypeList: List.from(map['effectTypeList']),
      agentInfoList:
          List.from(map['agentInfoList'].map((e) => AgentInfo.fromMap(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GestureSettingOption.fromJson(String source) =>
      GestureSettingOption.fromMap(json.decode(source));
}

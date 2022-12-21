import 'dart:convert';

class GestureSettingOption {
  GestureSettingOption(
      {required this.gestureTypeList,
      required this.effectTypeList,
      required this.agentNameList});

  List<String> gestureTypeList;

  List<String> effectTypeList;

  List<String> agentNameList;

  Map<String, dynamic> toMap() => {
        "gestureTypeList": gestureTypeList,
        "effectTypeList": effectTypeList,
        "agentNameList": agentNameList,
      };

  factory GestureSettingOption.fromMap(Map<String, dynamic> map) {
    return GestureSettingOption(
      gestureTypeList: List.from(map['gestureTypeList']),
      effectTypeList: List.from(map['effectTypeList']),
      agentNameList: List.from(map['agentNameList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GestureSettingOption.fromJson(String source) =>
      GestureSettingOption.fromMap(json.decode(source));
}

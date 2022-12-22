import 'dart:convert';

import 'package:final_frontend/data/model/effect_type.dart';
import 'package:final_frontend/data/model/gesture_type.dart';

class GestureSetting {
  GestureSetting(
      {required this.gestureType,
      required this.effectType,
      required this.agentTriggerName,
      required this.agentTargetName,
      required this.stateCommandName});

  GestureType gestureType;

  EffectType effectType;

  String? agentTriggerName;

  String? agentTargetName;

  String stateCommandName;

  Map<String, dynamic> toMap() => {
        "gestureType": gestureType,
        "effectType": effectType,
        "agentTriggerName": agentTriggerName,
        "agentTargetName": agentTargetName,
        "stateCommandName": stateCommandName,
      };

  factory GestureSetting.fromMap(Map<String, dynamic> map) {
    return GestureSetting(
      gestureType:
          GestureType.values[int.tryParse(map['gestureType']) ?? 0], // TODO:
      effectType:
          EffectType.values[int.tryParse(map['effectType']) ?? 0], // TODO:
      agentTriggerName: map['agentTriggerName'],
      agentTargetName: map['agentTargetName'],
      stateCommandName: map['stateCommandName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GestureSetting.fromJson(String source) =>
      GestureSetting.fromMap(json.decode(source));
}

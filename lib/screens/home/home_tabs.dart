import 'package:final_frontend/screens/home/gesture_setting/gesture_setting_page.dart';
import 'package:final_frontend/screens/home/agent_setting/agent_setting_page.dart';
import 'package:flutter/material.dart';

enum HomeTabs {
  agentSetting,
  gestureSetting,
}

extension MainTabsExt on HomeTabs {
  String getLabel() {
    switch (this) {
      case HomeTabs.agentSetting:
        return "設定Agent";
      case HomeTabs.gestureSetting:
        return "設定手勢";
    }
  }

  Widget getPage() {
    switch (this) {
      case HomeTabs.agentSetting:
        return AgentSettingPage();
      case HomeTabs.gestureSetting:
        return GestureSettingPage();
    }
  }

  MaterialColor getColor() {
    switch (this) {
      case HomeTabs.agentSetting:
        return Colors.amber;
      case HomeTabs.gestureSetting:
        return Colors.cyan;
    }
  }
}

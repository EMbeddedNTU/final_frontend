import 'dart:developer';

import 'package:final_frontend/data/client/bluetooth_service.dart';

import 'package:final_frontend/screens/util/base_model.dart';

class ConfigWifiModel extends BaseModel {
  ConfigWifiModel(this._btService) {
    _btService.startScaning();
  }

  final BTService _btService;
}

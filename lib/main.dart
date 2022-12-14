import 'package:final_frontend/environments/dev_config.dart';
import 'package:final_frontend/init_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:final_frontend/environments/environment_singleton.dart';
import 'package:final_frontend/my_app.dart';

void main() async {
  Environment(baseConfig: DevConfig());

  setupService();

  runApp(const MyApp());
}

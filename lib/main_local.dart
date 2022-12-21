import 'package:final_frontend/init_service.dart';
import 'package:flutter/material.dart';
import 'package:final_frontend/environments/environment_singleton.dart';
import 'package:final_frontend/environments/local_config.dart';
import 'package:final_frontend/my_app.dart';

void main() async {
  Environment(baseConfig: LocalConfig());

  setupService();

  runApp(const MyApp());
}

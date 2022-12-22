import 'dart:convert';

import 'package:final_frontend/data/model/agent_info.dart';
import 'package:final_frontend/data/model/notification.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final String _baseUrl;

  NotificationService({required String url}) : _baseUrl = url;

  Future<List<NotificationData>> getNotifications() async {
    const urlPart = "notification/notifications";
    final url = Uri.parse('$_baseUrl$urlPart');
    print(url);
    try {
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        List notifications = jsonDecode(response.body);
        return notifications
            .map((notification) => NotificationData.fromMap(notification))
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
}

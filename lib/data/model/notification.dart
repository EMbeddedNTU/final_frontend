import 'dart:convert';

class NotificationData {
  NotificationData(
      {required this.title, required this.time, required this.content});

  String title;

  String time;

  String content;

  Map<String, dynamic> toMap() => {
        "title": title,
        "time": time,
        "content": content,
      };

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
        title: map['title'], time: map['time'], content: map['content']);
  }

  String toJson() => json.encode(toMap());

  factory NotificationData.fromJson(String source) =>
      NotificationData.fromMap(json.decode(source));
}

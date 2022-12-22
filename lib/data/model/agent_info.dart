import 'dart:convert';

class AgentInfo {
  AgentInfo({required this.id, required this.name, required this.location});

  int id;

  String name;

  String location;

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "location": location,
      };

  factory AgentInfo.fromMap(Map<String, dynamic> map) {
    return AgentInfo(
        id: map['id'], name: map['name'], location: map['location'].toString());
  }

  String toJson() => json.encode(toMap());

  factory AgentInfo.fromJson(String source) =>
      AgentInfo.fromMap(json.decode(source));
}

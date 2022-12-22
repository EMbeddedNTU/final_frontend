import 'dart:convert';

class AgentInfo {
  AgentInfo(
      {required this.id,
      required this.name,
      required this.location,
      required this.typeList});

  int id;

  String name;

  String location;

  List<String> typeList;

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "location": location,
        "typeList": typeList,
      };

  factory AgentInfo.fromMap(Map<String, dynamic> map) {
    return AgentInfo(
      id: map['id'],
      name: map['name'],
      location: map['location'].toString(),
      typeList: List.from(map['typeList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgentInfo.fromJson(String source) =>
      AgentInfo.fromMap(json.decode(source));
}

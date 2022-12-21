import 'dart:convert';

class StateCommandOption {
  StateCommandOption({required this.id, required this.name});

  int id;

  String name;

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };

  factory StateCommandOption.fromMap(Map<String, dynamic> map) {
    return StateCommandOption(id: map['id'], name: map['name']);
  }

  String toJson() => json.encode(toMap());

  factory StateCommandOption.fromJson(String source) =>
      StateCommandOption.fromMap(json.decode(source));
}

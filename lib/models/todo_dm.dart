import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDM {
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool isDone;
  static const collectionName = "todos";

  TodoDM(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.isDone});

  TodoDM.fromJson(Map json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    Timestamp time = json["date"];
    date = time.toDate();
    isDone = json["isDone"];
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone
    };
  }
}

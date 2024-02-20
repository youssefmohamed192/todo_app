class TodoDM {
  String id;
  String title;
  String description;
  DateTime selectedDay;
  bool isDone;
  static const collectionName = "todos";

  TodoDM(
      {required this.id,
      required this.title,
      required this.description,
      required this.selectedDay,
      required this.isDone});
}

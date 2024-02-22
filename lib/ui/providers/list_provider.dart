import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_dm.dart';

class ListProvider extends ChangeNotifier {
  List<TodoDM> todos = [];
  DateTime selectedDay = DateTime.now();

  refreshTodosList() async {
    CollectionReference<TodoDM> todosCollection = FirebaseFirestore.instance
        .collection(TodoDM.collectionName)
        .withConverter<TodoDM>(fromFirestore: (docSnapshot, _) {
      Map json = docSnapshot.data() as Map;
      TodoDM todo = TodoDM.fromJson(json);
      return todo;
    }, toFirestore: (todoDm, _) {
      return todoDm.toJson();
    });
    QuerySnapshot<TodoDM> todosSnapshot =
    await todosCollection.orderBy("date").get();

    List<QueryDocumentSnapshot<TodoDM>> docs = todosSnapshot.docs;

    // for(int i =0; i < docs.length; i++){
    //   todos.add(docs[i].data());
    // }

    todos = docs.map((docSnapshot) {
      return docSnapshot.data();
    }).toList();

    todos =todos.where((todo) {
      if(todo.date.day != selectedDay.day ||
          todo.date.month != selectedDay.month ||
          todo.date.year != selectedDay.year){
        return false;
      }else {
        return true;
      }
    }).toList();
    notifyListeners();
  }
}

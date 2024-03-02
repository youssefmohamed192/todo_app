import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  static const String collectionName = "users";
  static AppUser? currentUser;
  late String id;
  late String username;
  late String email;

  AppUser({required this.id, required this.username, required this.email});

  AppUser.fromJson(Map json) {
    id = json["id"];
    username = json["username"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "username": username, "email": email};
  }

  static CollectionReference<AppUser> collection() {
    return FirebaseFirestore.instance
        .collection(AppUser.collectionName)
        .withConverter(fromFirestore: (snapShot, _) {
      return AppUser.fromJson(snapShot.data()!);
    }, toFirestore: (user, _) {
      return user.toJson();
    });
  }
}

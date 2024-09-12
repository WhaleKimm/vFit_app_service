import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    if (snapshot == null) {
      throw Exception('No data available for user');
    }
    return User(
      username: snapshot["username"] ?? 'N/A', // 예외 처리를 위해 기본값 제공
      uid: snapshot["uid"] ?? 'N/A',
      email: snapshot["email"] ?? 'N/A',
      photoUrl: snapshot["photoUrl"] ??
          'https://i.stack.imgur.com/l60Hf.png', // 기본 이미지 URL
      bio: snapshot["bio"] ?? '',
      followers: List.from(snapshot["followers"] ?? []),
      following: List.from(snapshot["following"] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}

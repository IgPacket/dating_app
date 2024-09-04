import 'package:cloud_firestore/cloud_firestore.dart';

class LikeItem {
  final int likes;

  const LikeItem({
    required this.likes,
  });

  factory LikeItem.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return LikeItem(
        likes: data['likes'],
    );
  }
}

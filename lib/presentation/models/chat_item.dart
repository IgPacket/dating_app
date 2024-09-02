import 'package:cloud_firestore/cloud_firestore.dart';

class ChatItem {
  final String profileImage;
  final String time;
  final String message;

  const ChatItem({
    required this.profileImage,
    required this.time,
    required this.message
  });

  factory ChatItem.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return ChatItem(
        profileImage: data['profileImage'],
        time: data['time'],
        message: data['message']
    );
  }
}

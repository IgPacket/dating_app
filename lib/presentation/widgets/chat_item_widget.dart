import 'package:flutter/material.dart';
import 'package:dating_app/presentation/models/chat_item.dart';

class ChatItemWidget extends StatelessWidget {
  final ChatItem chatItem;

  const ChatItemWidget({
    super.key,
    required this.chatItem
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(chatItem.profileImage),
            radius: 30,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatItem.time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  chatItem.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const Icon(
            Icons.more_vert,
            color: Colors.white,
            size: 24,
          )
        ],
      ),
    );
  }
}

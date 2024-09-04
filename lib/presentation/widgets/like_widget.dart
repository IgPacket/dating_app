import 'package:flutter/material.dart';

class LikeWidget extends StatelessWidget {
  final int likes;

  const LikeWidget({
    super.key,
    required this.likes
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          const Icon(Icons.heart_broken),
          const SizedBox(width: 16.0),
          const Text(
            'Вас лайкнуло: ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            likes.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            )
          )
        ],
      ),
    );
  }
}

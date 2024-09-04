import 'package:dating_app/presentation/models/chat_item.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final ChatItem chatItem;

  const ChatScreen({super.key, required this.chatItem});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool showStrip = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.chatItem.profileImage),
              radius: 15,
            ),
          ]
        ),
    ),

        body: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.only(top:100),
                child: Container(
                    color: Colors.black87,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Center(
                            child: Text('Начни общение', style: TextStyle(color: Colors.white),),
                          ),
                          Row(
                              children: [
                                const IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.add, color: Colors.white),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: const TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Сообщение...',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.emoji_emotions, color: Colors.white),
                                ),
                                const IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.mic, color: Colors.white),
                                ),
                              ]
                          ),
                        ]
                    )
                )
            ),
            if (showStrip)
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  color: Colors.purpleAccent,
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      const Icon(Icons.rocket_launch),
                      const Padding(padding: EdgeInsets.only(right: 10)),
                      const Text('2 общих соблазна',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,),),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showStrip = false;
                          });
                        }, icon: const Icon(Icons.close))
                    ],

                  )
                )
              )
          ],
        )

    );
  }
}




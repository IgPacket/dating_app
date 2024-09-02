import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/chat_item.dart';
import '../widgets/chat_item_widget.dart';
import 'chat_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int likes = 10;
  int _selectedIndex = 1;

  final CollectionReference _chatCollection = FirebaseFirestore.instance.collection('chats');

  // final List<ChatItem> _chatItems = [
  //   const ChatItem(
  //     profileImage: 'assets/images/profile_non_auth.jpg',
  //     time: '23 ч 43 мин',
  //     message: 'Отлично выглядишь',
  //   ),
  //   const ChatItem(
  //     profileImage: 'assets/images/profile_non_auth.jpg',
  //     time: '20 ч 40 мин',
  //     message: 'Встретимся? Я рядом',
  //   ),
  //   const ChatItem(
  //     profileImage: 'assets/images/profile_non_auth.jpg',
  //     time: '18 ч 40 мин',
  //     message: 'Встретимся?',
  //   ),
  //   const ChatItem(
  //     profileImage: 'assets/images/profile_non_auth.jpg',
  //     time: '09 ч 40 мин',
  //     message: 'Давно тебя хочу',
  //   ),
  //   const ChatItem(
  //     profileImage: 'assets/images/profile_non_auth.jpg',
  //     time: '03 ч 04 мин',
  //     message: 'Я в ванной.. Скинь фото..',
  //   ),
  //   const ChatItem(
  //     profileImage: 'assets/images/profile_non_auth.jpg',
  //     time: '01 ч 09 мин',
  //     message: 'Привет',
  //   ),
  //   const ChatItem(
  //     profileImage: 'assets/images/profile_non_auth.jpg',
  //     time: '01 ч 09 мин',
  //     message: 'Привет',
  //   ),
  //   const ChatItem(
  //     profileImage: 'assets/images/profile_non_auth.jpg',
  //     time: '01 ч 09 мин',
  //     message: 'Привет',
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      padding: const EdgeInsets.only(top: 150),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.black87,
          title: const Text(
            'Чаты',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  Text(
                    'OFF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  SizedBox(width: 8.0,),
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.amber,
                    size: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.black87,
          child: StreamBuilder<QuerySnapshot>(
            stream: _chatCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Ошибка: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              List<ChatItem> chatItems = snapshot.data!.docs
                .map((doc) => ChatItem.fromFirestore(doc))
                .toList();

              return ListView.builder(
                itemCount: chatItems.length,
                itemBuilder: (context, index) {
                  return ChatItemWidget(chatItem: chatItems[index]);
                },
              );
            }
          ),
        ),

      // body: Container(
      //   color: Colors.black87,
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Row(
      //           children: [
      //             const CircleAvatar(
      //               backgroundColor: Colors.purple,
      //               child: Icon(
      //                 Icons.favorite,
      //                 color: Colors.white,
      //                 size: 24,
      //               ),
      //             ),
      //             const SizedBox(width: 16.0,),
      //             Text(
      //               '$likes человека тебя лайкнули',
      //               style: const TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             )
      //           ],
      //         ),
      //          const SizedBox(height: 16.0),
      //         Expanded(
      //             child: ListView.builder(
      //               itemCount: _chatItems.length,
      //               itemBuilder: (context, index) {
      //                 return ChatItemWidget(
      //                   chatItem: _chatItems[index]
      //                 );
      //               }
      //             )
      //         )
      //       ],
      //     )
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.purple,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Icon(Icons.grid_view),
              ),
              label: ''
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Icon(Icons.chat),
              ),
              label: ''
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Icon(Icons.favorite),
              ),
              label: ''
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Icon(Icons.settings),
              ),
              label: ''
            )
          ]
        ),
      ),
    );
  }
}

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

class _ChatsScreenState extends State<ChatsScreen> with SingleTickerProviderStateMixin {

  int likes = 10;
  int _selectedIndex = 1;
  bool showBottomSheet = false;

  final CollectionReference _chatCollection = FirebaseFirestore.instance.collection('chats');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  const Text(
                    'OFF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  const SizedBox(width: 8.0,),
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    color: Colors.amber,
                    iconSize: 24,
                      onPressed: () {
                        setState(() {
                          showBottomSheet = true; // Показать BottomSheet
                        });
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
        body:
            Container(
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
                        .where((doc) => !(doc.data() as Map<String, dynamic>).containsKey('likes'))
                        .map((doc) => ChatItem.fromFirestore(doc))
                        .toList();

                    return ListView.builder(
                      itemCount: chatItems.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (!chatItems[index].time.contains('Вас')) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChatScreen(
                                              chatItem: chatItems[index]
                                          )
                                  )
                              );
                            }
                          },
                          child: ChatItemWidget(
                              chatItem: chatItems[index]
                          ),
                        );
                      },
                    );
                  }
              ),
        ),


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
        bottomSheet: showBottomSheet
          ? Container(
          height: 400, // Высота BottomSheet
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: SizedBox()),
                      Image.asset(
                        'assets/images/glasses.png', // Замените на путь к вашему изображению
                        height: 50,
                      ),
                    Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showBottomSheet = false; // Скрыть BottomSheet
                        });
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Text(
                  'РЕЖИМ ИНКОГНИТО НА 24 ЧАСА',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, left: 24, right: 24),
                child: Text(
                  'Стань невидимой в ленте и чатах, скрой объявление и наслаждайся незамеченным',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPriceButton('1', '99 ₽', 'assets/images/glasses_small.png'),
                    _buildPriceButton('3', '199 ₽', 'assets/images/glasses_small.png', isHit: true),
                    _buildPriceButton('7', '399 ₽', 'assets/images/glasses_small.png', isDiscount: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  width: double.infinity, //  Растягиваем кнопку по ширине
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Купить',
                      style: TextStyle(color: Colors.white,),),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                    child: Text(
                    'УСЛОВИЯ И ПОЛОЖЕНИЯ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        : const SizedBox(),
      ),
    );
  }
}

Widget _buildPriceButton(String days, String price, String iconAsset,
    {bool isHit = false, bool isDiscount = false}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              days,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              iconAsset,
              height: 24,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          price,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        if (isHit)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Хит',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        if (isDiscount)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '-42%',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
      ],
    ),
  );
}
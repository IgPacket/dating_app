import 'package:flutter/material.dart';
import 'package:dating_app/presentation/home.dart';
import 'package:dating_app/presentation/screens/chats_screen.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dating Demo App v0',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //primaryColor: Colors.white70,
        appBarTheme: const AppBarTheme(
          //backgroundColor: Colors.white70,
          elevation: 0,
        )
      ),
      // initialRoute: '/chats',
      // routes: {
      //   '/chats': (context) => const ChatsScreen(),
      // },
      home: const ChatsScreen(),
    );
  }
}
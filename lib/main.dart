import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:travelty/setting.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travelty',
      theme: ThemeData(
        useMaterial3: true,
        bottomAppBarColor: const Color.fromARGB(255, 91, 169, 66),
      ),
      home: const MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Widget currentPage = const Home();
  var navigation = ListQueue<Widget>();

  void nextPage(Widget page) {
    setState(() {
      if (currentPage.runtimeType != page.runtimeType) {
        navigation.addLast(currentPage);
        currentPage = page;
      }
    });
  }

  void previewPage() {
    setState(() {
      currentPage = navigation.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          nextPage(const Home());
        },
        tooltip: 'home',
        shape: const CircleBorder(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: const Color(0XFF3D722D),
        child: const Icon(
          Icons.map,
          size: 48,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0XFF5BA942),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  nextPage(Setting(
                    nextPage: nextPage,
                    previewPage: previewPage,
                  ));
                },
              ),
              label: "Setting"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profilo")
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

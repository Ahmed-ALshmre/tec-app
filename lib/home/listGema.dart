import 'package:flutter/material.dart';

class GameList extends StatefulWidget {
  static String routeName = "/gameList";
  const GameList({
    Key key,

  }) : super(key: key);
  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
    ));
  }
}

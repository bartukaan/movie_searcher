import 'package:flutter/material.dart';
import 'package:movie_app/utilities/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        title: Text("Movie Lovers"),
        backgroundColor: Colors.pink,
        expandedHeight: 200,
        pinned: false,
        snap: true,
        floating: true,
        actions: [
      //    TextField(controller: _textEditingController,decoration: kBoxDecorationStyle,),
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: IconButton(icon: Icon(Icons.search,size: 50,), onPressed: (){}),
          )
        ],
      ),
      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        delegate: SliverChildListDelegate([
          Container(
            color: Colors.purple,
            height: 200,
            width: 200,
          ),
          Container(
            color: Colors.yellow,
            height: 200,
            width: 200,
          ),
          Container(
            color: Colors.green,
            height: 200,
            width: 200,
          ),
          Container(
            color: Colors.redAccent,
            height: 200,
            width: 200,
          ),
          Container(
            color: Colors.purple,
            height: 200,
            width: 200,
          ),
          Container(
            color: Colors.blueAccent,
            height: 200,
            width: 200,
          ),
        ]),
      ),
    ]);
  }
}

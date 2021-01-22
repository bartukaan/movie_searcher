import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  Icon _searchIcon = Icon(
    Icons.search,
  );
  bool isSearchClicked = false;
  final TextEditingController _filter = new TextEditingController();

  List<String> itemList = [];

  @override
  void initState() {

    for(int count = 0; count < 50; count++)
    {
      itemList.add("Item $count");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              createSilverAppBar()
            ];
          },
          body: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    title: Text(itemList[index]),
                  ),
                );
              })),
    );
  }

  SliverAppBar createSilverAppBar() {
    return SliverAppBar(
      actions: <Widget>[
        RawMaterialButton(
          elevation: 0.0,
          child: _searchIcon,
          onPressed: () {
            _searchPressed();
          },
          constraints: BoxConstraints.tightFor(
            width: 56,
            height: 56,
          ),
          shape: CircleBorder(),
        ),

      ],
      expandedHeight: 400,
      collapsedHeight: 100,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(bottom: 15),
          centerTitle: true,
          title:isSearchClicked ? Container(
            padding: EdgeInsets.only(bottom: 2),
            //constraints:BoxConstraints(minHeight: 40, maxHeight: 40),
            width: MediaQuery.of(context).size.width * 0.50,
            child: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: CupertinoTextField(
                controller: _filter,
                keyboardType: TextInputType.text,
                placeholder: "Search..",
                placeholderStyle: TextStyle(
                  color: Color(0xffC4C6CC),
                  fontSize: 14.0,
                  fontFamily: 'Brutal',
                ),
                prefix: Padding(
                  padding:
                  const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                  child: Icon(Icons.search, ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
              ),
            ),
          ) : Text(
              "Movie Searcher"
          ),

          background: Image.network("https://miro.medium.com/max/3240/1*9-ujy3CCBhrpkvS7TMLcoQ.png", fit: BoxFit.cover,)
      ),
    );
  }

  void _searchPressed() {

    
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(
          Icons.close,
        );
        isSearchClicked = true;
      } else {
        this._searchIcon = Icon(
          Icons.search,

        );
        isSearchClicked = false;
        _filter.clear();
      }
    });
  }
}

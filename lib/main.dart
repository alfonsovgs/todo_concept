import 'package:flutter/material.dart';
import 'package:todo_concept_app/card_item_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController;
  var cardIndex = 0;
  var appColors = [
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0)
  ];
  var cardsList = [
    CardItemModel("Personal", Icons.account_circle, 9, 0.83),
    CardItemModel("Work", Icons.work, 12, 0.24),
    CardItemModel("Home", Icons.home, 7, 0.32)
  ];

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    Column _buildListItem() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16.0),
            child: Text(
              "TODAY : JUL 21, 2018",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            height: 350.0,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, position) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    cardsList[position].icon,
                                    color: appColors[position],
                                  ),
                                  Icon(
                                    Icons.more_vert,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    child: Text(
                                      '${cardsList[position].tasksRemaining} Tasks', //TODO: Cambiar
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    child: Text(
                                      "${cardsList[position].cardTitle}",
                                      style: TextStyle(fontSize: 28.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: LinearProgressIndicator(
                                      value: cardsList[position].taskCompletion,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  onHorizontalDragEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dx > 0) {
                      if (cardIndex > 0) cardIndex--;
                    } else if (cardIndex < 2) cardIndex++;

                    setState(() {
                      scrollController.animateTo((cardIndex) * 256.0,
                          duration: Duration(microseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    });
                  },
                );
              },
            ),
          ),
        ],
      );
    }

    Column _buildUserDetail() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Icon(
                      Icons.account_circle,
                      size: 45.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                    child: Text(
                      "Hello, Jane.",
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                  ),
                  Text(
                    "Looks like feel good.",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "You have 3 task to do today.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          _buildListItem()
        ],
      );
    }

    return Scaffold(
      backgroundColor: appColors[cardIndex],
      appBar: AppBar(
        title: Text(
          "TODO",
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: appColors[cardIndex],
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          )
        ],
        elevation: 0.0,
      ),
      drawer: Drawer(),
      body: Center(
        child: _buildUserDetail(),
      ),
    );
  }
}

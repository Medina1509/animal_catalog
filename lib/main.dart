import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'feedback.dart';

import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Animal Catalog'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              document['name'],
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffddddff),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              document['age'].toString(),
              style: Theme.of(context).textTheme.display1,
            ),
          )
        ],
      ),
      onTap: () {
        print("Let's go!");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('myFirstApp').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading ...');
            return ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.docs[index]),
            );
          }),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              padding: const EdgeInsets.all(25.0),
              icon: Icon(
                Icons.home,
                size: 30.0,
              ),
              onPressed: () {},
            ),
            PopupMenuButton(
              padding: const EdgeInsets.all(25.0),
              icon: Icon(
                Icons.share,
                size: 30.0,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text('Facebook'),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text('Instagram'),
                ),
              ],
            ),
            IconButton(
                padding: const EdgeInsets.all(25.0),
                icon: Icon(
                  Icons.email,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondScreen()));
                })
          ],
        ),
      ),
    );
  }
}

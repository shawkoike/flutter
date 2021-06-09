import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Regist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFirestorePage(),
    );
  }
}

class MyFirestorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyFirestorePageState();
}

class _MyFirestorePageState extends State<MyFirestorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final Map<String, String> data = {'name': '鈴木', 'age': '40'};
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('id_abc')
                    .set(data);
              },
              child: Text('コレクション + ドキュメント作成'),
            )
          ],
        ),
      ),
    );
  }

}
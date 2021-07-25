import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> sub() async {
  // RunApp前にFirebaseを初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Sample',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Sample'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {},
          child: IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () async {
              final result = await FirebaseFirestore.instance
                  .collection('feed_20200924')
                  .orderBy('feed_updateDate', descending: true)
                  .limit(1)
                  .get();
              for (final doc in result.docs) {
                print(doc.data().toString());
              }
            },
          ),
        ),
      ),
    );
  }
}

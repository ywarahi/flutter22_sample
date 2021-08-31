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
  Future<QuerySnapshot<Map<String, dynamic>>> _getToDo() {
    return FirebaseFirestore.instance
        .collection('todo')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Sample',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Sample'),
        ),
        body: FutureBuilder(
          future: _getToDo(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data?.docs.first.data();
              final title = result?['title'] as String;
              return Center(
                child: Text(title),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

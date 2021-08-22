import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final feedRepositoryProvider =
  Provider<Future<QuerySnapshot>>((ref) async {
    final result = ref.watch(firebaseFirestoreProvider)
        .collection('feed_20200924')
        .orderBy('feed_updateDate', descending: true)
        .limit(1)
        .get();
    return result;
  });

Future<void> sub() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(),
  ]);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () async {
              final result = await watch(feedRepositoryProvider);
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

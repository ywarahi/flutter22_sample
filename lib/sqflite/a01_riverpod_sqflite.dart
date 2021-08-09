import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

final dbHelperProvider = ChangeNotifierProvider<DBHelper>((ref) {
  return DBHelper();
});

final todoListProvider = StateProvider((ref) => 0);

class DBHelper with ChangeNotifier {
  DBHelper() {
    init();
  }

  late Future<Database> _db;
  List<Map<String, dynamic>> todoList = [];
  // [<String, Object>{
  //     'id': 0,
  //     'title': 'EMPTY',
  //     'priority': 0,
  //   }
  // ];

  Future<void> init() async {
    _db = openDatabase(
      join(await getDatabasesPath(), 'sample_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, priority INTEGER)',
        );
      },
      version: 1,
    );
    await updateTodoList();
    notifyListeners();
  }

  Future<void> insert(String table, Map<String, Object> data) async {
    final db = await _db;
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await _db;
    return db.query(table);
  }

  Future<void> updateTodoList() async {
    todoList = await getData('todo');
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod x sqflite'),
      ),
      floatingActionButton: Consumer(builder: (context, watch, child) {
        final dbHelper = watch(dbHelperProvider);
        return FloatingActionButton(
            onPressed: () async {
              final data = <String, Object>{
                'id': dbHelper.todoList.length + 1,
                'title': 'xxすること',
                'priority': 1,
              };
              await dbHelper.insert('todo', data);
              dbHelper.updateTodoList(); // ignore: unawaited_futures
            },
            child: const Icon(Icons.add));
      }),
      body: Consumer(
        builder: (context, watch, child) {
          final dbHelper = watch(dbHelperProvider);
          final _todoList = dbHelper.todoList;
          return Scrollbar(
              child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final _todo = _todoList[index];
                    final id = (_todo['id'] as int).toString();
                    final title = _todo['title'] as String;
                    return ListTile(
                      title: Text(id),
                      subtitle: Text(title),
                    );
                  }));
        },
      ),
    ));
  }
}

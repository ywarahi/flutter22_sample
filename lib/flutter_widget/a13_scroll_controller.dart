import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return _ListViewState();
  }
}

class _ListViewState extends State {
  final ScrollController _controller = ScrollController();
  final _items = <String>[];
  var _mPage = 0;

  @override
  void initState() {
    super.initState();
    getData();
    //Add listening to the controller
    _controller.addListener(() {
      //Determine if it slides to the bottom of the page
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        //If it is not the last page of data, generate new data to add to the list
        if (_mPage < 4) {
          _retrieveData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ListView Demo'),
        ),
        body: ListView.separated(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                //Determine whether the last item has been built
                if (index == _items.length) {
                  //Judge if it's the last page
                  if (_mPage < 4) {
                    //Not the last page, return to a loading window
                    return Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  } else {
                    //It's the last page. It shows that I have a bottom line.
                    return Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: const Text(
                        'I have a bottom line!!! ',
                        style: TextStyle(color: Colors.cyan),
                      ),
                    );
                  }
                } else {
                  return ListTile(title: Text('${_items[index]}'));
                }
              },
              //Split line constructor
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.blue,
                );
              },
              //_Items. Length + 1 is to make room for the loading of the last line
              itemCount: _items.length + 1),
        ),
    );
  }

  void getData() {
    //Initial data source
    for (var i = 0; i < 20; i++) {
      _items.insert(_items.length, 'article ${_items.length} of original data');
      print(_items[i]);
    }
  }

  void _retrieveData() {
    //Pull up to load new data
    _mPage++;
    Future<void>.delayed(const Duration(seconds: 2)).then((e) {
      for (var i = 0; i < 20; i++) {
        _items.insert(
            _items.length, 'this is the newly loaded ${_items.length} data');
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    //Remove monitoring to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }
}

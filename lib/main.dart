import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Pokego());
}

List<String>? _list = ['カード名'];
List<String>? _buyList = ['買い,'];
List<String>? _sellList = ['売り'];


class Pokego extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ポケカトレード表',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState()
  {
    _getSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ポケカトレード表'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () async {
            var gettext = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return Todopage();
              }),
            );

            var getbuytext = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return Todobuypage();
              }),
            );

            var getselltext = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return Todosellpage();
              }),
            );

            if (getselltext != null) {
              if (getselltext == String) getselltext = getselltext.toString();
              setState(() {
                _sellList!.add(getselltext);
              });
            } 

            if (getbuytext != null) {
              if (getbuytext == String) getbuytext = getbuytext.toString();
              setState(() {
                _buyList!.add(getbuytext + ',');
              });
            } 

            if (gettext != null) {
              setState(() {
                _list!.add(gettext);
              });
            } 
          },
          child: Icon(Icons.add),
        ),
        body: Container(
            child: (_list?.length != null)
                ? ListView.builder(
                    itemCount: _list!.length,
                    itemBuilder: (context, index) {
                      final text = _list![index];
                      return Dismissible(
                        key: Key(text),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black38),
                            ),
                          ),
                          child: ListTile(
                            title: Text(_list![index]),
                            trailing: Wrap(
                              children: <Widget>[
                                Text(_buyList![index].toString()),
                                Text(_sellList![index].toString()),
                              ],
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            _list!.removeAt(index);
                            _buyList!.removeAt(index);
                            _sellList!.removeAt(index);
                            _saveSetting();
                          });
                        },
                      );
                    })
                : Container())
        // ],
        );
  }
}

class Todopage extends StatefulWidget {
  @override
  _Todopage createState() => _Todopage();
}

class _Todopage extends State<Todopage> {
  String _text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_text, style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              Text('カード名'),
              TextField(
                onChanged: (String value) {
                  setState(() {
                    _text = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                // 横幅いっぱいに広げる
                width: double.infinity,
                // リスト追加ボタン
                child: ElevatedButton(
                  onPressed: () {
                    if (_text != '') Navigator.of(context).pop(_text);
                  },
                  child: Text('リスト追加', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                // 横幅いっぱいに広げる
                width: double.infinity,
                // キャンセルボタン
                child: TextButton(
                    // ボタンをクリックした時の処理
                    onPressed: () {
                      // "pop"で前の画面に戻る
                      setState(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return MyApp();
                          }),
                        );
                      });
                    },
                    child: Text('キャンセル')),
              ),
            ]),
      ),
    );
  }
}

class Todobuypage extends StatefulWidget {
  @override
  _Todobuypage createState() => _Todobuypage();
}

class _Todobuypage extends State<Todobuypage> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_text, style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              Text('買い'),
              TextField(
                onChanged: (String value) {
                  setState(() {
                    _text = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                // 横幅いっぱいに広げる
                width: double.infinity,
                // リスト追加ボタン
                child: ElevatedButton(
                  onPressed: () {
                    if (_text != '') {
                      Navigator.of(context).pop(_text);
                    }
                  },
                  child: Text('リスト追加', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                // 横幅いっぱいに広げる
                width: double.infinity,
                // キャンセルボタン
                child: TextButton(
                    // ボタンをクリックした時の処理
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return MyApp();
                          }),
                        );
                      });
                    },
                    child: Text('キャンセル')),
              ),
            ]),
      ),
    );
  }
}

class Todosellpage extends StatefulWidget {
  @override
  _Todosellpage createState() => _Todosellpage();
}

class _Todosellpage extends State<Todosellpage> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_text, style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              Text('売り'),
              TextField(
                onChanged: (String value) {
                  setState(() {
                    _text = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                // 横幅いっぱいに広げる
                width: double.infinity,
                // リスト追加ボタン
                child: ElevatedButton(
                  onPressed: () {
                    if (_text != '') Navigator.of(context).pop(_text);
                    setState(() {
                      _saveSetting();
                    });
                  },
                  child: Text('リスト追加', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                // 横幅いっぱいに広げる
                width: double.infinity,
                // キャンセルボタン
                child: TextButton(
                    // ボタンをクリックした時の処理
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return MyApp();
                          }),
                        );
                      });
                    },
                    child: Text('キャンセル')),
              ),
            ]),
      ),
    );
  }
}

  void _saveSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('list', _list!);
    pref.setStringList('listbuy', _buyList!);
    pref.setStringList('listsell', _sellList!);
  }

void _getSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _list = pref.getStringList('list') ?? [];
    _buyList = pref.getStringList('listbuy') ?? [];
    _sellList = pref.getStringList('listsell') ?? [];
}
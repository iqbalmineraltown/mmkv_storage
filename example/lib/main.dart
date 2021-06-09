import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mmkv_storage/mmkv_storage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _rootDir = 'Unknown';
  String _myString1;
  String _myString2;
  final _myController = TextEditingController();
  final String _keyString1 = "string1";
  final String _keyString2 = "string2";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String rootDir;
    String mystring;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      rootDir = await MmkvStorage.getRootDir();
      mystring = await MmkvStorage.decodeString(_keyString1);

      await MmkvStorage.encodeBool("bool", true);
      bool b = await MmkvStorage.decodeBool("bool");
      print(b.toString());

      await MmkvStorage.encodeInt("int", 121212);
      int i = await MmkvStorage.decodeInt("int");
      print(i.toString());

      await MmkvStorage.encodeDouble("double", 1212.1212);
      double d = await MmkvStorage.decodeDouble("double");
      print(d.toString());

      // long is also int in dart ? failed on android
      // await MmkvStorage.encodeLong("long", 1212121212);
      // int l = await MmkvStorage.decodeLong("long");
      // print(l.toString());

      /// TODO handle bytes type on ios
      // await MmkvStorage.encodeUint8List(
      //     "uint8", Uint8List.fromList(List<int>.from([i, l])));
      // Uint8List ui8 = await MmkvStorage.decodeUint8List("uint8");
      // print(ui8.toString());
    } on PlatformException {
      rootDir = 'Failed to get';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _rootDir = rootDir;
      _myString1 = mystring;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonColor: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('MmkvStorage Plugin'),
        ),
        body: ListView(
          children: [
            Column(
              children: <Widget>[
                Text('Root Directory : $_rootDir\n'),
                Text('Decoded value key=$_keyString1 :$_myString1'),
                Text('Decoded value key=$_keyString2 :$_myString2'),
                TextField(
                  controller: _myController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        MmkvStorage.encodeString(
                            _keyString1, _myController.text.toString());
                      },
                      child: Text(
                        'Encode1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        MmkvStorage.decodeString(_keyString1).then((value) {
                          setState(() {
                            _myString1 = value;
                          });
                        });
                      },
                      child: Text(
                        'Decode1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _myString1 = null;
                        });
                      },
                      child: Text(
                        'Clear1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await MmkvStorage.removeValueForKey(_keyString1);
                        var str1 = await MmkvStorage.decodeString(_keyString1);
                        setState(() {
                          _myString1 = str1;
                        });
                      },
                      child: Text(
                        'Remove1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        MmkvStorage.encodeString(
                            _keyString2, _myController.text.toString());
                      },
                      child: Text(
                        'Encode2',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        MmkvStorage.decodeString(_keyString2).then((value) {
                          setState(() {
                            _myString2 = value;
                          });
                        });
                      },
                      child: Text(
                        'Decode2',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _myString2 = null;
                        });
                      },
                      child: Text(
                        'Clear2',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await MmkvStorage.removeValueForKey(_keyString2);
                        var str2 = await MmkvStorage.decodeString(_keyString2);
                        setState(() {
                          _myString2 = str2;
                        });
                      },
                      child: Text(
                        'Remove2',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    await MmkvStorage.removeAll();
                    var str1 = await MmkvStorage.decodeString(_keyString1);
                    var str2 = await MmkvStorage.decodeString(_keyString2);

                    setState(() {
                      _myString1 = str1;
                      _myString2 = str2;
                    });
                  },
                  child: Text(
                    'RemoveAll',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Text("Encode<N>: Store value to cache N"),
                Text("Decode<N>: Decode value from cache N"),
                Text("Clear<N>: Clear decoded value N (not deleting cache)"),
                Text("Remove<N>: Delete cache N"),
                Text("RemoveAll: Delete all cache"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

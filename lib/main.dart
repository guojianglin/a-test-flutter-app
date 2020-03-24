import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var results;
  var code;
  int width;
  var loginDatashow;
  var postData;
  Map<String, String> headers = {};
  String rawCookie;
  var loginMessage;

  void _incrementCounter() async {
//    Dio dio = new Dio();
//
//    Cookie cookie = Cookie('JSESSIONID', 'D79F7243641C4D9F88B258B158B5D3D9');
//    dio.options.headers = {'cookie': cookie};

//    FormData formData = FormData.from({
//      'pid': 136,
//      'amount': 100.0,
//      'bankco': 'YLKJ',
//    });
//    Map<String, dynamic> data = {'username': 'abc111'};
//
//    Response resResults = await dio.get(
//      'http://192.168.31.186:28082/api/need-security-code',
//      queryParameters: data,
//    );
//
//
//    print('res ======$resResults');
//    setState(() {
//      _counter++;
//      results = resResults.headers;
//    });

    //http://192.168.31.186:28082/Peter 你连接我本地 用app测一下

//    Map<String, String> header = headers;
//    print('header======$header');

//    var url = 'http://192.168.31.186:28082/api/need-security-code';
    var url = 'http://43.243.50.103:16888/api/need-security-code';
    http.Response response = await http.get(url, headers: headers);
    updateCookie(response);
    print('headers======$headers');
    setState(() {
      _counter++;
      results = response.body;
    });
  }

  test() async {
//    Dio dio = new Dio();
//    Cookie cookie = Cookie('JSESSIONID', 'D79F7243641C4D9F88B258B158B5D3D9');
//    dio.options.headers = {'cookie': cookie};
//    Map<String, dynamic> data = {'backWidth': 344, 'targetWidth': 63};
//
//    Response code1 = await dio.get(
//      'http://192.168.31.186:28082/api/utils/login-security-code',
//      queryParameters: data,
//    );
//    var url =
//        'http://192.168.31.186:28082/api/utils/login-security-code?backWidth=344&targetWidth=63';
    var url =
        'http://43.243.50.103:16888/api/utils/login-security-code?backWidth=344&targetWidth=63';
    http.Response code1 = await http.get(url, headers: headers);
    updateCookie(code1);
    print('headers2======$headers');
    setState(() {
      _counter++;
      code = code1.body;
      width = jsonDecode(code1.body)['data']['position'];
    });
  }

  login() async {
//    Dio dio = new Dio();
//    Map<String, dynamic> data = {
//      'username': 'abc111',
//      'password': 'a123456',
//      'width': width
//    };
//    Cookie cookie = Cookie('JSESSIONID', 'D79F7243641C4D9F88B258B158B5D3D9');
//    dio.options.headers['cookie'] = {'cookie': cookie};
//
//    postData = data;

    Map<String, String> data;
    if (width != null) {
      data = {
        'username': 'abc111',
        'password': 'a1234567',
        'width': width.toString()
      };
    } else {
      data = {
        'username': 'abc111',
        'password': 'a1234567',
      };
    }

    postData = data;

    print('postData === $postData');

//    var url = 'http://192.168.31.186:28082/api/login';
    var url = 'http://43.243.50.103:16888/api/login';

    http.Response res = await http.post(
      url,
      body: postData,
      headers: headers,
    );
    print('headers3======$headers');

    setState(() {
      _counter++;
      loginDatashow = res.headers;
      loginMessage = res.body;
    });
  }

  void updateCookie(http.Response response) {
    rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$results',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
              Text('$code'),
              RaisedButton(
                onPressed: test,
                child: Text('test'),
              ),
              Divider(),
              Text('$postData'),
              Text('$loginMessage'),
              Text(
                '$loginDatashow',
              ),
              RaisedButton(
                onPressed: login,
                child: Text('login'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

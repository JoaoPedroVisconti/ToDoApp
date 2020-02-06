import 'package:flutter/material.dart';
import 'package:todoapp/UI/Intray/intray_page.dart';
import 'package:todoapp/UI/Login/loginscreen.dart';
import 'package:todoapp/models/global.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _calculation, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.none:
              return Text('Press button to start');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Awaiting result...');
            case ConnectionState.done:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              return Text('Result: ${snapshot.data}'); 
          }
          return null; //Unreachable
        },
      ),
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

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        color: Colors.yellow,
        home: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: new Scaffold(
              body: Stack(
                children:<Widget>[
                  TabBarView(
                    children: [
                        IntrayPage(),
                      new Container(
                        color: Colors.lightGreen,
                      ),
                      new Container(
                        color: Colors.red,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Intray", style: intrayTitleStyle),
                        Container()
                      ],
                    )
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.only(top: 120, left: MediaQuery.of(context).size.width*0.5 - 40),
                    child: FloatingActionButton(
                      elevation: 10,
                      child: Icon(
                        Icons.add, size: 70,
                        ),
                      backgroundColor: lightGreyColor,
                      onPressed: () {},
                    ),
                  )
                ]
              ),
              appBar: AppBar(
                elevation: 15,
                  title: new TabBar(
                  tabs: [
                    Tab(
                      icon: new Icon(Icons.home),
                    ),
                    Tab(
                      icon: new Icon(Icons.perm_identity),
                    ),
                    Tab(
                      icon: new Icon(Icons.settings),
                    ),
                  ],
                  labelColor: darkGreyColor,
                  unselectedLabelColor: Colors.blue,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.all(5.0),
                  indicatorColor: Colors.transparent,
                ),
                backgroundColor: Colors.white,
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/UI/Intray/intray_page.dart';
import 'package:todoapp/UI/Login/loginscreen.dart';
import 'package:todoapp/bloc/resources/repository.dart';
import 'package:todoapp/models/global.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/models/classes/user.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';

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
        dialogBackgroundColor: Colors.transparent,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TaskBloc tasksBloc;
  String apiKey = "";
  Repository _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: signinUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.hasData){  
          apiKey = snapshot.data;
          tasksBloc = TaskBloc(apiKey);
        } else {
          print("No data apiKey - main 44");
        }
        // String apiKey = snapshot.data;
        // return LoginPage();
        // apiKey.length > 0 ? getHomePage() : 
        return apiKey.length > 0 ? getHomePage() : LoginPage(login: login, newUser: false,);
      },
    );
  }

  void login(){
    setState(() {
      build(context);
    });
  }

  Future signinUser() async{
    String userName = "";
    apiKey = await getApiKey();
    if (apiKey != null){
      if (apiKey.length > 0) {
        userBloc.signinUser("","", apiKey);
      } else {
        print("No api Key - main 66");
      }
    } else {
      apiKey = "";
    }
    return apiKey;
  }

  //Storing the api key on the device
  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return await prefs.getString("API_Token");
  }

  Widget getHomePage(){
    return MaterialApp(
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(children: <Widget>[
              TabBarView(
                children: [
                  IntrayPage(apiKey: apiKey),
                  new Container(
                    child: Center(
                      child: FlatButton(
                        color: Colors.red,
                        child: Text("Logout"),
                        onPressed:(){
                          logout();
                        },
                      ),
                    ),
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
                        bottomRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Intray", style: intrayTitleStyle),
                      Container()
                    ],
                  )),
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.only(
                    top: 120,
                    left: MediaQuery.of(context).size.width * 0.5 - 40),
                child: FloatingActionButton(
                  elevation: 10,
                  child: Icon(
                    Icons.add,
                    size: 70,
                  ),
                  backgroundColor: lightGreyColor,
                  onPressed: _showAddDialog,
                ),
              )
            ]),
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

  void _showAddDialog() {
    TextEditingController taskName = new TextEditingController();
    TextEditingController deadline = new TextEditingController();
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
            padding: EdgeInsets.all(20),
            constraints: BoxConstraints.expand(height: 250, width: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: lightBlackColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Add New Task", style: whiteTitle,),
                Container(
                  child: TextField(
                    controller: taskName,
                    decoration: InputDecoration(
                      hintText: "Name of task",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: deadline,
                    decoration: InputDecoration(
                      hintText: "Deadline",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: lightGreyColor,
                      child: Text("Cancel", style: whiteBottomTitle,),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      color: lightGreyColor,
                      child: Text("Add", style: whiteBottomTitle,),
                      onPressed: (){
                        if (taskName != null) {
                          addTask(taskName.text, deadline.text);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void addTask(String taskName, String deadline) async {
    print(apiKey);
    await _repository.addUserTask(this.apiKey, taskName, deadline);
  }
  
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("API_Token", "");
    setState(() {
      build(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
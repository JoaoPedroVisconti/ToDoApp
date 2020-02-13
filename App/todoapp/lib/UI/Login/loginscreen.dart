import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';
import 'package:todoapp/models/classes/user.dart';
import 'package:todoapp/models/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback login;
  final bool newUser;

  const LoginPage({Key key, this.login, this.newUser,})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: darkGreyColor,
      body: Center(
        child: widget.newUser ? getSignupPage() : getSinginPage(),
      ),
    );
  }

  Widget getSinginPage() {
    TextEditingController usernameText = new TextEditingController();
    TextEditingController passwordText = new TextEditingController();
    return Container(
      margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Welcome", style: bigLightBlueTitle,),
          Container(
            height:200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Theme(
                  data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    controller: usernameText,
                    autofocus: false,
                    style: TextStyle(fontSize: 22.0, color: darkGreyColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Username",
                      contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    controller: passwordText,
                    autofocus: false,
                    style: TextStyle(fontSize: 22.0, color: darkGreyColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  child: Text("Sign in", style: lighTodoTitle,),
                  onPressed: (){
                    if (usernameText.text != null || passwordText.text != null){
                      userBloc.signinUser(usernameText.text, passwordText.text, "").then((_){
                        widget.login();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text("Don´t you have an Account?", style: lighText, textAlign: TextAlign.center,),
                FlatButton(
                  child: Text("Create an Account", style: lighBoldText),
                  onPressed: (){
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getSignupPage() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'email'),
          ),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(hintText: 'Username'),
          ),
          TextField(
            controller: firstnameController,
            decoration: InputDecoration(hintText: 'First Name'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          FlatButton(
            color: lightGreyColor,
            child: Text("Sign up for god sake"),
            onPressed: () {
              if (usernameController.text != null ||
                  passwordController.text != null ||
                  emailController.text != null) {
                userBloc
                    .registerUser(
                        usernameController.text,
                        firstnameController.text ?? "",
                        "",
                        passwordController.text,
                        emailController.text)
                    .then((_) {
                  widget.login();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

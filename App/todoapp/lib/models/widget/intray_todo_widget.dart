import 'package:flutter/material.dart';
import 'package:todoapp/models/global.dart';


class IntrayTodo extends StatelessWidget {
  final String title;
  IntrayTodo({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      padding: EdgeInsets.all(10),
      height: 140,
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,            
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Radio(

          ),
          Column(
            children: <Widget>[
              Text(title, style: darkTodoTitle,)
            ],
          )
        ]
      ),
    );
  }

}
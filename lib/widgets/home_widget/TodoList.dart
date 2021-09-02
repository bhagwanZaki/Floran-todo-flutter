import 'dart:convert';

import 'package:floran_todo/model/Todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class TodoList extends StatefulWidget {
  final Function() notifyParent;
  const TodoList({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
  }

  refresh() {
    print('refreshing todolist');
    widget.notifyParent();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: TodosModel.items.length,
        itemBuilder: (context, index) {
          final todo = TodosModel.items[index];
          return InkWell(
            child: TodoItem(
              todo: todo,
              notifyParent: refresh,
            ),
          );
        });
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  final Function() notifyParent;
  const TodoItem({Key? key, required this.todo, required this.notifyParent})
      : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final url = "http://192.168.2.101:8000/api/todos/";
  @override
  void initState() {
    super.initState();
  }

  complete(int id, bool complete) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('Token');
    DateTime date = DateTime.now();
    var finaldate = "${date.year}-${date.month}-${date.day}";
    print(finaldate);
    final res = await http.patch(Uri.parse(url + '$id/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token $token'
        },
        body: jsonEncode({'completed': complete, 'completed_at': finaldate}));

    print(res.body);
    print(res.statusCode);

    if (res.statusCode == 200) {
      print('refreshing item');

      widget.notifyParent();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print("loading item ,,,,");
    return Container(
      // padding: new EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: Row(children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.todo.title.text.lg
                    .color(context.theme.accentColor)
                    .make(),
                widget.todo.completed
                    ? "Completed On - ${widget.todo.completed_at}"
                        .text
                        .caption(context)
                        .make()
                    : "Complete by -  ${widget.todo.date_completed_by}"
                        .text
                        .caption(context)
                        .make()
              ],
            )),
            ButtonBar(
                alignment: MainAxisAlignment.end,
                buttonPadding: EdgeInsets.all(1),
                children: [
                  ElevatedButton(
                      child: widget.todo.completed
                          ? Icon(CupertinoIcons.checkmark_alt)
                          : Text("Complete"),
                      onPressed: () =>
                          complete(widget.todo.id, !widget.todo.completed),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(StadiumBorder()),
                        backgroundColor: MaterialStateProperty.all(
                            context.theme.buttonColor),
                      ))
                ]),
          ]),
        ),
      ),
    );
    // return VxBox(

    //   child: Row(
    //     children: [
    //       Expanded(
    //         child: Column(
    //           children: [
    //             todo.title.text.lg.color(context.theme.accentColor).make(),
    //             todo.date_completed_by.text.caption(context).make()
    //           ],
    //         )
    //       ),
    //       ButtonBar(
    //         alignment: MainAxisAlignment.end,
    //         buttonPadding: EdgeInsets.all(1),
    //         children: [
    //           ElevatedButton(
    //             child: "Complete".text.bold.xl.make(),
    //             onPressed: (){},
    //             style: ButtonStyle(
    //               shape: MaterialStateProperty.all(StadiumBorder()),
    //               backgroundColor: MaterialStateProperty.all(context.theme.buttonColor),
    //             )
    //           )
    //         ],
    //       )
    //     ],
    //   )
    // ).color(context.cardColor).roundedLg.square(100).make().py12();
  }
}

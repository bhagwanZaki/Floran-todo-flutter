import 'dart:convert';

import 'package:floran_todo/model/Chartdata.dart';
import 'package:floran_todo/model/Todo.dart';
import 'package:floran_todo/utils/Constants.dart';
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
    widget.notifyParent();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
          shrinkWrap: true,
          reverse: true,
          itemCount: TodosModel.items.length,
          itemBuilder: (context, index) {
            final todo = TodosModel.items[index];
            return InkWell(
              child: TodoItem(
                todo: todo,
                notifyParent: refresh,
              ),
            );
          }),
    );
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
  final url = Constants.baseUrl + "todos/";
  @override
  void initState() {
    super.initState();
  }

  //////////////////////////////////////////
  ///////  COMPELETE COMMAND FUNCION  //////
  //////////////////////////////////////////

  complete(int id, bool complete) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('Token');
    DateTime date = DateTime.now();
    var finaldate = "${date.year}-${date.month}-${date.day}";
    final res = await http.patch(Uri.parse(url + '$id/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token $token'
        },
        body: jsonEncode({'completed': complete, 'completed_at': finaldate}));

    var dataReceived = jsonDecode(res.body);
    var index = TodosModel.items
        .indexWhere((element) => element.id == dataReceived['id']);

    if (res.statusCode == 200) {
      TodosModel.items[index] = Todo.fromMap(dataReceived);
      var id = prefs.getInt('id');
      Map<String, String> qParams = {
        'id': "$id",
      };
      var response2 = await http
          .get(Uri.parse(Constants.baseUrl + 'flutterchart').replace(queryParameters: qParams));
      var chartdata = response2.body;

      final chartdecode = jsonDecode(chartdata);
      var charts = chartdecode['data'];
      ChartDataList.items = List.from(charts)
          .map<ChartData>((item) => ChartData.fromMap(item))
          .toList();
      widget.notifyParent();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}

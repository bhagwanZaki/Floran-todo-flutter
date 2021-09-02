import 'dart:convert';

import 'package:floran_todo/model/Todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateTodoPage extends StatefulWidget {
  final Function() notifyParent;
  const CreateTodoPage(BuildContext context,
      {Key? key, required this.notifyParent})
      : super(key: key);

  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController todoinput = TextEditingController();
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  final url = "http://192.168.2.101:8000/api/todos/";

  submitForm(BuildContext context, String todo, DateTime date) async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('Token');
      var finaldate = '${date.year}-${date.month}-${date.day}';
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Token $token'
          },
          body: jsonEncode(
              <String, String>{'title': todo, 'date_completed_by': finaldate}));
      print(response.body);
      print(response.statusCode);
      var resdata = jsonDecode(response.body);
      if (response.statusCode == 201) {
        Navigator.of(context).pop();
        TodosModel.items.add(Todo.fromMap(resdata));
        print(TodosModel.items);
        widget.notifyParent();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(CupertinoIcons.clear),
                  backgroundColor: Colors.redAccent,
                ),
              )),
          Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: todoinput,
                    decoration: InputDecoration(
                        hintText: "To-do title",
                        labelText: "To-do",
                        labelStyle:
                            TextStyle(color: context.theme.accentColor)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 0.0),
                    child: Text("Date"),
                  ),
                  Card(
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.only(left: 5.0, right: 5.0, top: 0.0),
                      title: Text("${date.year}-${date.month}-${date.day}"),
                      trailing: Icon(Icons.keyboard_arrow_down_sharp),
                      onTap: _pickDate,
                    ),
                  ),
                  SizedBox(height: 10),
                  Material(
                    color: context.theme.buttonColor,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () => submitForm(context, todoinput.text, date),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        height: 40,
                        // width: 150,
                        alignment: Alignment.center,
                        child: Text(
                          "Create",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  _pickDate() async {
    DateTime? pickeddate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 20),
        lastDate: DateTime(DateTime.now().year + 50));
    if (pickeddate != null) {
      print(pickeddate);
      setState(() {
        date = pickeddate;
      });
    }
  }
}

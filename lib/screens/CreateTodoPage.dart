import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage(BuildContext context, {Key? key}) : super(key: key);

  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
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
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: "To-do title",
                    labelText: "To-do",
                    labelStyle: TextStyle(color: context.theme.accentColor)),
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
                        borderRadius:
                            BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () {},
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            height: 40,
                            // width: 150,
                            alignment: Alignment.center,
                            child: Text(
                              "Create",
                              style: TextStyle(fontSize: 20,color: Colors.white),
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
      setState(() {
        date = pickeddate;
      });
    }
  }
}

import 'package:floran_todo/model/Todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: TodosModel.items.length,
        itemBuilder: (context, index) {
          final todo = TodosModel.items[index];
          return InkWell(
            child: TodoItem(todo: todo),
          );
        });
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: new EdgeInsets.all(10.0),  
      child: Card(
        shape: RoundedRectangleBorder(  
              borderRadius: BorderRadius.circular(15.0),  
            ),  
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: Row(
            children: [
              Expanded(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    todo.title.text.lg.color(context.theme.accentColor).make(),
                    todo.completed ? "Completed On - ${todo.completed_at}".text.caption(context).make() : "Complete by -  ${todo.date_completed_by}".text.caption(context).make()
                  ],
                )
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                buttonPadding: EdgeInsets.all(1),
                children: [
                  ElevatedButton(
                    child:todo.completed ? Icon(CupertinoIcons.checkmark_alt) : Text("Complete"),
                    onPressed: (){},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(StadiumBorder()),
                      backgroundColor: MaterialStateProperty.all(context.theme.buttonColor),
                      
                    )
                  )
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

import 'dart:convert';

import 'package:floran_todo/model/Chartdata.dart';
import 'package:floran_todo/model/Todo.dart';
import 'package:floran_todo/screens/CreateTodoPage.dart';
import 'package:floran_todo/widgets/Appbar.dart';
import 'package:floran_todo/widgets/home_widget/Chart.dart';
import 'package:floran_todo/widgets/home_widget/TodoList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    loaddata();
    super.initState();
  }

  final url = "http://192.168.2.101:8000/api/";
  var dataloaded = 0;
  loaddata() async {
    print("loading");
    // loading the todo data from json
    // var tododata = await rootBundle.loadString("assets/files/todo.json");

    // loading data from api

    var response = await http.get(Uri.parse(url + 'test/'));
    final tododata = response.body;
    print(response.statusCode);

    final decodedata = jsonDecode(tododata);
    print(decodedata);
    // var todos = decodedata['todos'];
    var todos = decodedata;
    TodosModel.items =
        List.from(todos).map<Todo>((item) => Todo.fromMap(item)).toList();

    // laoding chart data
    // var chartdata = await rootBundle.loadString("assets/files/chartdata.json");

    // loading chart data by api
    var response2 = await http.get(Uri.parse(url + 'flutterchart'));
    var chartdata = response2.body;

    final chartdecode = jsonDecode(chartdata);
    var charts = chartdecode['data'];
    ChartDataList.items = List.from(charts)
        .map<ChartData>((item) => ChartData.fromMap(item))
        .toList();
    dataloaded = 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CreateTodoPage(context);
              });
        },
        child: Icon(CupertinoIcons.plus),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: Vx.m32,
                child: Appbar(),
              ),
              TodoChart().expand(),
              if (dataloaded != 1)
                CircularProgressIndicator().centered().expand()
              else
                TodoList().expand()
            ],
          ),
        ),
      ),
    );
  }
}

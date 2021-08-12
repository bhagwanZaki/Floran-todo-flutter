import 'package:floran_todo/model/Chartdata.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TodoChart extends StatefulWidget {
  const TodoChart({Key? key}) : super(key: key);

  @override
  _TodoChartState createState() => _TodoChartState();
}

class _TodoChartState extends State<TodoChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(series: <ChartSeries<ChartData, int>>[
      LineSeries<ChartData, int>(
        dataSource: ChartDataList.items,
        xValueMapper: (ChartData charts, _) => charts.date,
        yValueMapper: (ChartData charts, _) => charts.data,
        color: Colors.orange,
      )
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class TasksStatusList extends StatefulWidget {
  List chartData ;
  TasksStatusList({super.key , required this.chartData});

  @override
  State<TasksStatusList> createState() => _TasksStatusListState();
}

class _TasksStatusListState extends State<TasksStatusList> {

  List chartData = [];

  @override
  void didUpdateWidget(covariant TasksStatusList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.chartData != oldWidget.chartData) {
      setState(() {
        chartData = widget.chartData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 8),
      child: SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        margin: const EdgeInsets.all(0),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(),
        series: [
          ColumnSeries(
            dataSource: chartData,
            yValueMapper: (data,_) => data[0],
            xValueMapper: (data,_) => data[1],
            pointColorMapper: (data,_) => data[2],
          )
        ],

      ),
    );
  }
}

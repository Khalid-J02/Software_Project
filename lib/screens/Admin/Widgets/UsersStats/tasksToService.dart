import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class TasksToServiceList extends StatefulWidget {
  final List<dynamic> chartData; // Add this line
  const TasksToServiceList({super.key, required this.chartData}); // Modify this line

  @override
  State<TasksToServiceList> createState() => _TasksToServiceListState();
}

class _TasksToServiceListState extends State<TasksToServiceList> {

  Map<String, Color> serviceColors = {
    "Surveyor" : const Color.fromRGBO(82, 98, 255, 1),
    "Engineering Office" : const Color.fromRGBO(46, 198, 255, 1),
    "Constructor" : const Color.fromRGBO(123, 201, 82, 1),
    "Plumbing Technician" : const Color.fromRGBO(255, 171, 67, 1),
    "Electrical Technician" : const Color.fromRGBO(252, 91, 57, 1),
    "Insulation Technician" : const Color.fromRGBO(139, 135, 130, 1),
    "Carpenter" : const Color.fromRGBO(34, 135, 130, 1),
    "Plasterer" : const Color.fromRGBO(139, 34, 130, 1),
    "Tile Contractor" : const Color.fromRGBO(139, 135, 34, 1),
    "Window Installer" : const Color.fromRGBO(67, 135, 66, 1),
    "Painter" : const Color.fromRGBO(67, 55, 2, 1),
  };

  @override
  Widget build(BuildContext context) {
    List convertedChartData = widget.chartData.map((item) {
      String city = item["serviceType"];
      int count = item["taskCount"];
      Color color = serviceColors[city] ?? Colors.grey;
      return [count, city, color];
    }).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        margin: const EdgeInsets.all(0),
        series: [
          PieSeries(
            dataSource: convertedChartData,
            yValueMapper: (data,_) => data[0],
            xValueMapper: (data,_) => data[1],
            radius: '80%',
            explode: true,
            pointColorMapper: (data,_) => data[2],
            dataLabelMapper: (data,_) => data[1].toString(),
            dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(color: Colors.black , fontSize: 13),
                labelPosition: ChartDataLabelPosition.outside
            ),
          )
        ],
      ),
    );
  }
}

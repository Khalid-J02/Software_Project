import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class TasksToServiceDist extends StatefulWidget {
  const TasksToServiceDist({super.key});

  @override
  State<TasksToServiceDist> createState() => _TasksToServiceDistState();
}

class _TasksToServiceDistState extends State<TasksToServiceDist> {

  List chartData = [
    [40 , 'Surveyor' , const Color.fromRGBO(82, 98, 255, 1)],
    [88 , 'Eng. Office' , const Color.fromRGBO(46, 198, 255, 1)],
    [20 , 'Constructor' , const Color.fromRGBO(123, 201, 82, 1)],
    [25 , 'Plumbing Tech.' , const Color.fromRGBO(255, 171, 67, 1)],
    [15 , 'Electrical Tech.' , const Color.fromRGBO(252, 91, 57, 1)],
    [11 , 'Insulation Tech.' , const Color.fromRGBO(139, 135, 130, 1)],
    [67 , 'Carpenter' , const Color.fromRGBO(34, 135, 130, 1)],
    [102 , 'Plasterer' , const Color.fromRGBO(139, 34, 130, 1)],
    [55 , 'Tile Cont.' , const Color.fromRGBO(139, 135, 34, 1)],
    [3 , 'Window Inst.' , const Color.fromRGBO(67, 135, 66, 1)],
    [77 , 'Painter' , const Color.fromRGBO(67, 55, 2, 1)],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        margin: const EdgeInsets.all(0),
        series: [
          PieSeries(
            dataSource: chartData,
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

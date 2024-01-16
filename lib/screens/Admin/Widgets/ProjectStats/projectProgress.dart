import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ProjectsProgressDist extends StatefulWidget {
  const ProjectsProgressDist({super.key});

  @override
  State<ProjectsProgressDist> createState() => _ProjectsCityDistState();
}

class _ProjectsCityDistState extends State<ProjectsProgressDist> {

  List chartData = [
    [40 , ' < 25%' , const Color.fromRGBO(82, 98, 255, 1) ],
    [12 , ' < 50%' , const Color.fromRGBO(46, 198, 255, 1) ],
    [20 , ' < 75%' , const Color.fromRGBO(123, 201, 82, 1) ],
    [25 , ' > 75%' , const Color.fromRGBO(255, 171, 67, 1) ],
  ];

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      margin: const EdgeInsets.all(0),
      series: [
        PieSeries(
          dataSource: chartData,
          yValueMapper: (data,_) => data[0],
          xValueMapper: (data,_) => data[1],
          radius: '90%',
          explode: true,
          pointColorMapper: (data,_) => data[2],
          dataLabelMapper: (data,_) => data[1].toString(),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(color: Colors.black , fontSize: 15),
            labelPosition: ChartDataLabelPosition.outside
          ),
        )
      ],

      legend: const Legend(
          overflowMode: LegendItemOverflowMode.wrap,
          isVisible: true,
          position: LegendPosition.top,
          orientation: LegendItemOrientation.horizontal,
          textStyle: TextStyle(fontSize: 15),
          iconHeight: 10,
          iconBorderWidth: 10
      ),
    );
  }
}

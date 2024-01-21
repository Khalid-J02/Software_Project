import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ProjectsProgressList extends StatefulWidget {
  final List<dynamic> chartData;
  const ProjectsProgressList({super.key, required this.chartData});

  @override
  State<ProjectsProgressList> createState() => _ProjectsCityDistState();
}

class _ProjectsCityDistState extends State<ProjectsProgressList> {

  List<dynamic> getFormattedChartData() {
    List<dynamic> formattedData = [];
    for (var entry in widget.chartData) {
      entry.forEach((key, value) {
        String label;
        Color color;
        switch (key) {
          case "projects_0_to_25":
            label = '0% - 25%';
            color = const Color.fromRGBO(82, 98, 255, 1);
            break;
          case "projects_26_to_50":
            label = '26% - 50%';
            color = const Color.fromRGBO(46, 198, 255, 1);
            break;
          case "projects_51_to_75":
            label = '51% - 75%';
            color = const Color.fromRGBO(123, 201, 82, 1);
            break;
          case "projects_76_to_100":
            label = '76% - 100%';
            color = const Color.fromRGBO(255, 171, 67, 1);
            break;
          default:
            label = 'Unknown';
            color = Colors.grey;
        }
        formattedData.add([value, label, color]);
      });
    }
    return formattedData;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> chartData = getFormattedChartData();
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
          iconHeight: 15,
          iconBorderWidth: 10
      ),
    );
  }
}

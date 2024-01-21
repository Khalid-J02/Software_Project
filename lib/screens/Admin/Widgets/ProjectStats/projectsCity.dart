import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ProjectsCityList extends StatefulWidget {
  final List<dynamic> chartData;
  const ProjectsCityList({super.key, required this.chartData});

  @override
  State<ProjectsCityList> createState() => _ProjectsCityListState();
}

class _ProjectsCityListState extends State<ProjectsCityList> {

  Map<String, Color> cityColors = {
    "Nablus": const Color.fromRGBO(82, 98, 255, 1),
    "Ramallah": const Color.fromRGBO(46, 198, 255, 1),
    "Tulkarm": const Color.fromRGBO(123, 201, 82, 1),
    "Qalqilya": const Color.fromRGBO(255, 171, 67, 1),
    "Jenin": const Color.fromRGBO(252, 91, 57, 1),
    "Jericho": const Color.fromRGBO(139, 135, 130, 1),
  };

  @override
  Widget build(BuildContext context) {
    List convertedChartData = widget.chartData.map((item) {
      String city = item["ProjectCity"];
      int count = item["projectCount"];
      Color color = cityColors[city] ?? Colors.grey;
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
            radius: '90%',
            explode: true,
            pointColorMapper: (data,_) => data[2],
            // pointRadiusMapper : (data, _) =>
            // dataLabelMapper: (data,_) => data[1].toString(),
            // dataLabelSettings: const DataLabelSettings(
            //   isVisible: true,
            //   textStyle: TextStyle(color: Colors.black , fontSize: 15),
            //   labelPosition: ChartDataLabelPosition.outside
            // ),
          )
        ],

        legend: const Legend(
          overflowMode: LegendItemOverflowMode.wrap,
          isVisible: true,
          position: LegendPosition.right,
          orientation: LegendItemOrientation.vertical,
          textStyle: TextStyle(fontSize: 15),
          iconHeight: 10,
          iconBorderWidth: 10
        ),
      ),
    );
  }
}

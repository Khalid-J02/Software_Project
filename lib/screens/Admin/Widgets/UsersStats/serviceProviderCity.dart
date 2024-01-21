import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ServiceProvidersCityList extends StatefulWidget {
  final List<dynamic> chartData;
  const ServiceProvidersCityList({super.key, required this.chartData});

  @override
  State<ServiceProvidersCityList> createState() => _ServiceProvidersCityListState();
}

class _ServiceProvidersCityListState extends State<ServiceProvidersCityList> {

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
      String city = item["UserCity"];
      int count = item["serviceProviderCount"];
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
          )
        ],

        legend: const Legend(
            overflowMode: LegendItemOverflowMode.wrap,
            isVisible: true,
            position: LegendPosition.left,
            orientation: LegendItemOrientation.vertical,
            textStyle: TextStyle(fontSize: 15),
            iconHeight: 10,
            iconBorderWidth: 10
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ServiceProvidersCityDist extends StatefulWidget {
  const ServiceProvidersCityDist({super.key});

  @override
  State<ServiceProvidersCityDist> createState() => _ServiceProvidersCityDistState();
}

class _ServiceProvidersCityDistState extends State<ServiceProvidersCityDist> {

  List chartData = [
    [40 , 'Nablus' , const Color.fromRGBO(82, 98, 255, 1)],
    [12 , 'Ramallah' , const Color.fromRGBO(46, 198, 255, 1)],
    [20 , 'Tulkarm' , const Color.fromRGBO(123, 201, 82, 1)],
    [25 , 'Qalqilya' , const Color.fromRGBO(255, 171, 67, 1)],
    [15 , 'Jenin' , const Color.fromRGBO(252, 91, 57, 1)],
    [11 , 'Jericho' , const Color.fromRGBO(139, 135, 130, 1)],
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
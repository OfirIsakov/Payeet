import 'dart:ffi';

import 'package:Payeet/grpc/protos/payeet.pb.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Payeet/globals.dart';

class BarChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  makeTransactionsIcon(),
                  const SizedBox(
                    width: 38,
                  ),
                  Text(
                    'Transactions',
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'state',
                    style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BarChart(
                    BarChartData(
                      maxY: 20,
                      barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.grey,
                            getTooltipItem: (_a, _b, _c, _d) => null,
                          ),
                          touchCallback: (response) {
                            if (response.spot == null) {
                              setState(() {
                                touchedGroupIndex = -1;
                                showingBarGroups = List.of(rawBarGroups);
                              });
                              return;
                            }

                            touchedGroupIndex =
                                response.spot.touchedBarGroupIndex;

                            setState(() {
                              if (response.touchInput is FlLongPressEnd ||
                                  response.touchInput is FlPanEnd) {
                                touchedGroupIndex = -1;
                                showingBarGroups = List.of(rawBarGroups);
                              } else {
                                showingBarGroups = List.of(rawBarGroups);
                                if (touchedGroupIndex != -1) {
                                  double sum = 0;
                                  for (BarChartRodData rod
                                      in showingBarGroups[touchedGroupIndex]
                                          .barRods) {
                                    sum += rod.y;
                                  }
                                  final avg = sum /
                                      showingBarGroups[touchedGroupIndex]
                                          .barRods
                                          .length;

                                  showingBarGroups[touchedGroupIndex] =
                                      showingBarGroups[touchedGroupIndex]
                                          .copyWith(
                                    barRods: showingBarGroups[touchedGroupIndex]
                                        .barRods
                                        .map((rod) {
                                      return rod.copyWith(y: avg);
                                    }).toList(),
                                  );
                                }
                              }
                            });
                          }),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 20,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return 'Mn';
                              case 1:
                                return 'Te';
                              case 2:
                                return 'Wd';
                              case 3:
                                return 'Tu';
                              case 4:
                                return 'Fr';
                              case 5:
                                return 'St';
                              case 6:
                                return 'Sn';
                              default:
                                return '';
                            }
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 32,
                          reservedSize: 14,
                          getTitles: (value) {
                            if (value == 0) {
                              return '1K';
                            } else if (value == 10) {
                              return '5K';
                            } else if (value == 19) {
                              return '10K';
                            } else {
                              return '';
                            }
                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Theme.of(context).highlightColor.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Theme.of(context).highlightColor.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Theme.of(context).highlightColor.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Theme.of(context).highlightColor.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Theme.of(context).highlightColor.withOpacity(0.4),
        ),
      ],
    );
  }
}

class Chart1 extends StatefulWidget {
  final String transferEmail;
  final List<HistoryResponse> transHistory;
  const Chart1({Key key, this.transferEmail, this.transHistory})
      : super(key: key);

  @override
  _Chart1State createState() => _Chart1State();
}

class _Chart1State extends State<Chart1> {
  var incomeData = Map<int, int>();
  var outcomeData = Map<int, int>();

  void func() {
    incomeData.clear();
    outcomeData.clear();
    var now = DateTime.now();
    // var history = widget.transHistory.where((element) {
    //   var date =
    //       DateTime.fromMillisecondsSinceEpoch(element.time.toInt() * 1000);
    //   var diff = now.difference(date);
    //   return diff.inDays >= 0 && diff.inDays <= 7;
    // }).toList();
    var history = widget.transHistory.reversed;
    for (var item in history) {
      //print(item);
      bool income = item.receiverMail == widget.transferEmail;
      if (income) {
        addToMap(incomeData, item);
      } else {
        addToMap(outcomeData, item);
      }
    }
  }

  void addToMap(Map<int, int> map, HistoryResponse item) {
    var day = DateTime.fromMillisecondsSinceEpoch(item.time.toInt() * 1000).day;
    if (map.containsKey(day)) {
      map[day] += item.amount;
    } else {
      map.addAll({day: item.amount});
    }
  }

  bool checkIfSameDay() {
    return true;
  }

  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    func();
    return SfCartesianChart(
        backgroundColor: Theme.of(context).backgroundColor,
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        title: ChartTitle(
            textStyle: TextStyle(color: Theme.of(context).highlightColor)),
        primaryXAxis: CategoryAxis(
            labelStyle: TextStyle(
                color: Color(0xff7589a2),
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        primaryYAxis: NumericAxis(
            labelStyle: TextStyle(
                color: Color(0xff7589a2),
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          ColumnSeries<MapEntry<int, int>, String>(
              isVisibleInLegend: true,
              spacing: 0.4,
              name: "spending",
              dataSource: outcomeData.entries.toList(),
              xValueMapper: (MapEntry<int, int> d, _) => d.key.toString(),
              yValueMapper: (MapEntry<int, int> d, _) => d.value,
              color: const Color(0xffff5182),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              dataLabelSettings: DataLabelSettings(
                textStyle: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontWeight: FontWeight.bold),
                isVisible: true,
              )),
          ColumnSeries<MapEntry<int, int>, String>(
            isVisibleInLegend: true,

            spacing: 0.4,
            name: "income",

            dataSource: incomeData.entries.toList(),
            xValueMapper: (MapEntry<int, int> d, _) => d.key.toString(),
            yValueMapper: (MapEntry<int, int> d, _) => d.value,
            color: const Color(0xff53fdd7),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            //dataLabelSettings: DataLabelSettings(isVisible: true)
          ),

          // LineSeries<myData, String>(
          //   isVisibleInLegend: true,
          //   name: "outcome",
          //   color: Colors.blue,
          //   dataSource: getOutcomeData(),
          //   xValueMapper: (myData d, _) => d.x,
          //   yValueMapper: (myData d, _) => d.y,
          // ),
          // LineSeries<myData, String>(
          //   isVisibleInLegend: true,
          //   name: "outcome",
          //   color: Colors.green,
          //   dataSource: getIncomeData(),
          //   xValueMapper: (myData d, _) => d.x,
          //   yValueMapper: (myData d, _) => d.y,
          // ),
        ]);
  }

  dynamic getIncomeData() {
    List<myData> columndata = <myData>[
      // myData("yakir", 10),
      // myData("BFG", 20),
      // myData("fsf", 30),
      // myData("sdfd", 40),
      // myData("zae", 50),
      // myData("zae1", 50),
      // myData("zae2", 50),
    ];

    for (var item in incomeData.entries) {
      columndata.add(myData(item.key.toString(), item.value));
    }

    //List<myData> columndata = incomeData.entries.map((item) {}).toList();

    // print(incomeData);
    print(columndata);

    return columndata;
  }

  dynamic getOutcomeData() {
    // List<myData> columndata = <myData>[
    //   myData("yakir", 20),
    //   myData("BFG", 11),
    //   myData("fsf", 20),
    //   myData("sdfd", 40),
    //   myData("zae", 50),
    //   myData("zae1", 30),
    //   myData("zae2", 20),
    // ];

    List<myData> columndata = outcomeData.entries.map((item) {
      myData(item.key.toString(), item.value);
    }).toList();

    print(outcomeData);

    return columndata;
  }
}

class myData {
  String x;
  int y;
  myData(this.x, this.y);
}

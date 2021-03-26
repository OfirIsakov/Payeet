import 'package:Payeet/grpc/protos/payeet.pb.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

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
    var history = widget.transHistory.reversed;
    for (var item in history) {
      bool income = item.receiverMail == widget.transferEmail;
      if (income) {
        addToMap(incomeData, item);
      } else {
        addToMap(outcomeData, item);
      }
    }
  }

  void addToMap(Map<int, int> map, HistoryResponse item) {
    var day = 0;
    if (map.containsKey(day)) {
      map[0] += item.amount;
    } else {
      map.addAll({0: item.amount});
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
        legend: Legend(isVisible: true, position: LegendPosition.bottom, textStyle: TextStyle(color: Theme.of(context).primaryColor)),
        title: ChartTitle(
            textStyle: TextStyle(color: Theme.of(context).highlightColor)),
        primaryXAxis: CategoryAxis(
            labelStyle: TextStyle(
                color: Theme.of(context).highlightColor,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        primaryYAxis: NumericAxis(
            labelStyle: TextStyle(
                color: Theme.of(context).highlightColor,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          ColumnSeries<MapEntry<int, int>, String>(
              isVisibleInLegend: true,

              spacing: 0.4,
              name: "spending",
              dataSource: outcomeData.entries.toList(),
              xValueMapper: (MapEntry<int, int> d, _) => 'Spendings',
              yValueMapper: (MapEntry<int, int> d, _) => d.value,
              color: const Color(0xffff5182),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          ColumnSeries<MapEntry<int, int>, String>(
              isVisibleInLegend: true,
              spacing: 0.4,
              name: "income",
              dataSource: incomeData.entries.toList(),
              xValueMapper: (MapEntry<int, int> d, _) => 'Income',
              yValueMapper: (MapEntry<int, int> d, _) => d.value,
              color: const Color(0xff53fdd7),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        ]);
  }

  dynamic getIncomeData() {
    List<myData> columndata = <myData>[];

    for (var item in incomeData.entries) {
      columndata.add(myData(item.key.toString(), item.value));
    }

    print(columndata);

    return columndata;
  }

  dynamic getOutcomeData() {
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

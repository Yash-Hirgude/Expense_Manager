import 'package:expensemanager/models/transaction.dart';
import 'package:expensemanager/widgets/chart_column.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class chart extends StatefulWidget {
  List<transaction> groupedTransaction;
  chart(this.groupedTransaction);
  @override
  _chartState createState() => _chartState();
}

class _chartState extends State<chart> {
  // late double weekSpending;
  List<Map<String, Object>> get recentTx {
    return List.generate(
      7,
      (index) {
        DateTime weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;
        for (var tx in widget.groupedTransaction) {
          if (tx.date.day == weekDay.day &&
              tx.date.month == weekDay.month &&
              tx.date.year == weekDay.year) {
            totalSum += tx.amount;
          }
        }
        return {
          "WeekInitial": DateFormat.E().format(weekDay).substring(0, 1),
          "TotalSum": totalSum
        };
      },
    ).reversed.toList();
  }

  double get weekSpending {
    return recentTx.fold(0.0, (sum, element) {
      return sum + double.parse(element["TotalSum"].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: recentTx.map(
            (e) {
              return Flexible(
                fit: FlexFit.tight,
                child: chartCol(
                  e["WeekInitial"].toString(),
                  // weekSpending / double.parse(e["TotalSum"].toString()),
                  double.parse(e["TotalSum"].toString()) == 0.0 ? 0.0 : double.parse(e["TotalSum"].toString()) / weekSpending,
                  double.parse(
                    e["TotalSum"].toString(),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

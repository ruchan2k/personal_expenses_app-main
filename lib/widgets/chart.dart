import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum += double.parse(item['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: groupedTransactionsValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'].toString(),
                  (data['amount'] as double),
                  totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
                ),
              );
            }).toList(),
          ),
        ));
  }
}

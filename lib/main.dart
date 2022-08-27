import 'package:expensemanager/widgets/chart.dart';
import 'package:flutter/material.dart';
import './widgets/transactions_list.dart';
import './widgets/bottom_sheet.dart';
import './models/transaction.dart';
void main() => runApp(_ExpenseManager());

class _ExpenseManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.green),
        backgroundColor: Colors.purple,
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
              buttonColor: Colors.purple,
              textTheme: ButtonTextTheme.accent,
              colorScheme: Theme.of(context)
                  .colorScheme
                  .copyWith(secondary: Colors.white),
            ),
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
      ),
      home: ExpenseApp(),
    );
  }
}

class ExpenseApp extends StatefulWidget {
  
  const ExpenseApp({Key? key}) : super(key: key);
  
  @override
  _ExpenseAppState createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
  
  late List<transaction> transactionsNow = [];

  void addTransaction(String title,double amount,DateTime date){
    transaction tx = transaction(DateTime.now().toString(),title,amount,date);
    setState(() {
    transactionsNow.add(tx);
    });
  }

  void _iconButtonPressed(){
    showModalBottomSheet(context: context, builder: (ctx){
      return bottomSheet(addTransaction);
    });
  }

  List<transaction> get recentTransactions{
    return transactionsNow.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  void deleteTx(String itemId) {
    setState(() {
      transactionsNow.removeWhere((element) => element.id == itemId);
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final appbar = AppBar(
        title: Text("ExpenseManager"),
        actions: [
          Container(
              // padding: EdgeInsets.fromLTRB(0, 4, 25, 4),
              width: mediaquery.size.width*0.2,
              child: IconButton(
                icon: Icon(Icons.add,color: Colors.white,),
                onPressed: _iconButtonPressed,

              )),
        ],
      );
    return Scaffold(
      appBar: appbar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(height: (mediaquery.size.height - appbar.preferredSize.height - mediaquery.padding.top) * 0.3,child: chart(recentTransactions),),
              Container(height: (mediaquery.size.height - appbar.preferredSize.height - mediaquery.padding.top) * 0.7,child: transactionlist(transactionsNow,deleteTx)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class transactionlist extends StatelessWidget {
  List<transaction> transactionsNow;
  Function deleteTx;
  transactionlist(this.transactionsNow,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return transactionsNow.isEmpty
              ? const Text("No Transactions")
              : Card(
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).backgroundColor,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          transactionsNow[index].amount
                              .toStringAsFixed(2),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    title: Text(
                      transactionsNow[index].title.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(transactionsNow[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.orange[700]),
                      onPressed: () =>
                          deleteTx(transactionsNow[index].id),
                    ),
                  ),
                );
        },
        itemCount: transactionsNow.length,
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// import '../models/transaction.dart';

// class TransactionList extends StatelessWidget {
//   final List<transaction> transactions;
//   final Function deleteTx;

//   TransactionList(this.transactions, this.deleteTx);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 450,
//       child: transactions.isEmpty
//           ? Column(
//               children: <Widget>[
//                 Text(
//                   'No transactions added yet!',
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                     height: 200,
//                     child: Image.asset(
//                       'assets/images/waiting.png',
//                       fit: BoxFit.cover,
//                     )),
//               ],
//             )
//           : ListView.builder(
//               itemBuilder: (ctx, index) {
//                 return Card(
//                   elevation: 5,
//                   margin: EdgeInsets.symmetric(
//                     vertical: 8,
//                     horizontal: 5,
//                   ),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       radius: 30,
//                       child: Padding(
//                         padding: EdgeInsets.all(6),
//                         child: FittedBox(
//                           child: Text('\$${transactions[index].amount}'),
//                         ),
//                       ),
//                     ),
//                     title: Text(
//                       transactions[index].title,
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     subtitle: Text(
//                       DateFormat.yMMMd().format(transactions[index].date),
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete),
//                       color: Theme.of(context).errorColor,
//                       onPressed: () => deleteTx(transactions[index].id),
//                     ),
//                   ),
//                 );
//               },
//               itemCount: transactions.length,
//             ),
//     );
//   }
// }
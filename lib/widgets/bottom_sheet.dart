// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class bottomSheet extends StatefulWidget {
  Function addtransaction;
  bottomSheet(this.addtransaction);
  @override
  _bottomSheetState createState() => _bottomSheetState();
}

class _bottomSheetState extends State<bottomSheet> {
  // Function addtransaction = widget.addtransaction;
  final textController = TextEditingController();
  final amountController = TextEditingController();
  DateTime ? dateNow;

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dateNow = pickedDate;
      });
    });
  }

  void onSubmit(TextEditingController title,TextEditingController amount,DateTime ? dateN){
    String titleText = title.text;
    double amountText = double.parse(amount.text);
    
    if(titleText == null || amountText <=0 || dateN == null){
      return;
    }
    widget.addtransaction(titleText,amountText,dateN);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: "Title"),
              keyboardType: TextInputType.text,
              controller: textController,
            ),
            const SizedBox(
              height: 4,
            ),
            TextField(
              decoration: const InputDecoration(hintText: "Amount"),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              controller: amountController,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateNow == null ? "No Date Choosen" : 'Picked Date: ${DateFormat.yMd().format(dateNow ?? DateTime.now())}',
                  style: TextStyle(color: Colors.grey[900],fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: _datePicker,
                    child: const Text(
                      "Choose Date",
                      style: TextStyle(color: Colors.purple),
                    ))
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            TextButton(
              onPressed: () => onSubmit(textController,amountController,dateNow),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

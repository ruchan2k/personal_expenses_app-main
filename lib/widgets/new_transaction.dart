import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  var _selectedDate = DateTime.now();

  void submitData() {
    final enteredTittle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    final enteredDate = _selectedDate;

    if (enteredTittle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTransaction(
      titleController.text,
      double.parse(amountController.text),
      enteredDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        _selectedDate = pickedDate;
        setState(
          () => _selectedDate = pickedDate,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(DateFormat.yMMMd().format(_selectedDate)),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Pick Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  submitData();
                },
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textColor: Theme.of(context).textTheme.button?.color,
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  Function deleteTransaction;
  Function editTransactions;
  TransactionList(
      this._userTransactions, this.deleteTransaction, this.editTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: _userTransactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraint) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions yet',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraint.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child:
                                Text('\$${_userTransactions[index].amount}')),
                      ),
                    ),
                    title: Text('${_userTransactions[index].title}',
                        style: Theme.of(context).textTheme.title),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(_userTransactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FlatButton.icon(
                                icon: Icon(Icons.edit),
                                label: Text('Edit'),
                                onPressed: () => editTransactions(context,
                                    edit: true, tx: _userTransactions[index]),
                              ),
                              FlatButton.icon(
                                icon: Icon(Icons.delete),
                                label: Text('Delete'),
                                textColor: Theme.of(context).errorColor,
                                onPressed: () => deleteTransaction(
                                    _userTransactions[index].id),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => editTransactions(context,
                                    edit: true, tx: _userTransactions[index]),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                color: Theme.of(context).errorColor,
                                onPressed: () => deleteTransaction(
                                    _userTransactions[index].id),
                              ),
                            ],
                          ),
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}

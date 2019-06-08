import 'package:flutter/material.dart';
import 'package:ExamenParcial/infrastructure/account_sqflite_repository.dart';
import 'package:ExamenParcial/infrastructure/database_provider.dart';
import 'package:ExamenParcial/model/account.dart';
import 'package:ExamenParcial/screens/account_detail.dart';

class AccountList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountListState();
}

class AccountListState extends State<AccountList> {
  AccountSqfliteRepository AccountRepository = AccountSqfliteRepository(DatabaseProvider.get);
  List<Account> accounts;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (accounts == null) {
      accounts = List<Account>();
      getData();
    }
    return Scaffold(
      body: AccountListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          navigateToDetail(Account('', '', 4, ''));
        }
        ,
        tooltip: "Add new Account",
        child: new Icon(Icons.add),
      ),
    );
  }
  
  ListView AccountListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,// getColor(this.accounts[position].saldo),
              child:Text(this.accounts[position].saldo.toString()),
            ),
          title: Text(this.accounts[position].name),
          subtitle: Text(this.accounts[position].name),
          onTap: () {
            debugPrint("Tapped on " + this.accounts[position].id.toString());
            navigateToDetail(this.accounts[position]);
          },
          ),
        );
      },
    );
  }
  
  void getData() {    
      final AccountsFuture = AccountRepository.getList();
      AccountsFuture.then((accountList) {
        setState(() {
          accounts = accountList;
          count = accountList.length;
        });
        debugPrint("Cuentas " + count.toString());
      });
  }

  Color getColor(int semester) {
    switch (semester) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.yellow;
        break;
      case 4:
        return Colors.green;
        break;
      default:
        return Colors.green;
    }
  }

  void navigateToDetail(Account account) async {
    bool result = await Navigator.push(context, 
        MaterialPageRoute(builder: (context) => AccountDetail(account)),
    );
    if (result == true) {
      getData();
    }
  }
}

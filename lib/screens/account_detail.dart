import 'package:flutter/material.dart';
import 'package:ExamenParcial/infrastructure/account_sqflite_repository.dart';
import 'package:ExamenParcial/infrastructure/database_provider.dart';
import 'package:ExamenParcial/model/account.dart';

AccountSqfliteRepository AccountRepository = AccountSqfliteRepository(DatabaseProvider.get);

final List<String> choices = const <String> [
  'Save Account & Back',
  'Delete Account',
  'Back to List'
];

final List<String> monedas = const <String> [
  'SOL',
  'USD'
];

const mnuSave = 'Save Account & Back';
const mnuDelete = 'Delete Account';
const mnuBack = 'Back to List';

class AccountDetail extends StatefulWidget {
  final Account account;
  AccountDetail(this.account);

  @override
  State<StatefulWidget> createState() => AccountDetailState(account);
}

class AccountDetailState extends State<AccountDetail> {
  Account account;
  AccountDetailState(this.account);
  int _monto = 100;
  String _name = 'Cuenta  de Ahorros';
  String _description = 'Cuenta de ahorros en soles';
  
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = account.name;
    descriptionController.text = account.description;
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(account.name),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: select,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding( 
        padding: EdgeInsets.only(top:35.0, left: 10.0, right: 10.0),
        child: ListView(children: <Widget>[Column(
        children: <Widget>[
          TextField(
            controller: nameController,
            style: textStyle,
            onChanged: (value) => this.updateName(),
            decoration: InputDecoration(
              labelText: "Name",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:15.0, bottom: 15.0),
            child: TextField(
            controller: descriptionController,
            style: textStyle,
            onChanged: (value) => this.updateDescription(),
            decoration: InputDecoration(
              labelText: "Description",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          )),
          ListTile(title:DropdownButton<String>(
            items: monedas.map((String moneda) {
              return DropdownMenuItem<String> (
                value:moneda,
                child: Text(moneda),
              );
            }).toList(),
            style: textStyle,
            value: account.moneda,
            onChanged: (value) => updateMoneda(value),
          ))
        ],
      )],)
      )
    );
  }

  void select (String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true);
        if (account.id == null) {
          return;
        }
        result = await AccountRepository.delete(account);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Delete Account"),
            content: Text("The Account has been deleted"),
          );
          showDialog(
            context: context,
            builder: (_) => alertDialog);
          
        }
        break;
        case mnuBack:
          Navigator.pop(context, true);
          break;
      default:
    }
  }

  void save() {
    if (account.id != null) {
      debugPrint('update');
      AccountRepository.update(account);
    }
    else {
      debugPrint('insert');
      AccountRepository.insert(account);
    }
    Navigator.pop(context, true);
  }

  void updateMoneda(String value) {
    account.moneda = value;
  }

  // int retrieveSemester(int value) {
  //   return _semesterList[value-1];
  // }

  void updateName(){
    account.name = nameController.text;
  }

  void updateDescription() {
    account.description = descriptionController.text;
  }
}

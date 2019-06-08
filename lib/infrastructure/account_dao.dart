import 'package:ExamenParcial/infrastructure/dao.dart';
import 'package:ExamenParcial/model/account.dart';

class AccountDao implements Dao<Account> {
  final tableName = 'account';
  final columnId = 'id';
  final _columnName = 'name';
  final _columnDescription = 'descripcion';
  final _columnMoneda = 'moneda';
  final _columnSaldo = 'saldo';

  @override
  String get createTableQuery =>
    "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
    " $_columnName TEXT,"
    " $_columnDescription TEXT,"
    " $_columnMoneda TEXT,"
    " $_columnSaldo INT)";

  @override
  Account fromMap(Map<String, dynamic> query) {
    Account account = Account( query[_columnName], query[_columnMoneda], query[_columnSaldo], query[_columnDescription]);
    return account;
  }

  @override
  Map<String, dynamic> toMap(Account account) {
    return <String, dynamic>{
      _columnName: account.name,
      _columnDescription: account.description,
      _columnMoneda: account.moneda,
      _columnSaldo: account.saldo
    };
  }

  Account fromDbRow(dynamic row) {
    return Account.withId(row[columnId], row[_columnName], row[_columnMoneda], row[_columnSaldo], row[_columnDescription]);
  }

  @override
  List<Account> fromList(result) {
    List<Account> accounts = List<Account>();
    var count = result.length;
    for (int i = 0; i < count; i++) {
      accounts.add(fromDbRow(result[i]));
    }
    return accounts;
  }
}

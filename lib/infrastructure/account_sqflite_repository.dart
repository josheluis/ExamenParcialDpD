import 'package:ExamenParcial/infrastructure/account_dao.dart';
import 'package:ExamenParcial/infrastructure/account_repository.dart';
import 'package:ExamenParcial/infrastructure/database_provider.dart';
import 'package:ExamenParcial/model/account.dart';

class AccountSqfliteRepository implements AccountRepository {
  final dao = AccountDao();

  @override
  DatabaseProvider databaseProvider;

  AccountSqfliteRepository(this.databaseProvider);

  @override
  Future<int> insert(Account account) async {
    final db = await databaseProvider.db();
    var id = await db.insert(dao.tableName, dao.toMap(account));
    return id;
  }

  @override
  Future<int> delete(Account account) async {
    final db = await databaseProvider.db();
    int result = await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [account.id]);
    return result;
  }

  @override
  Future<int> update(Account account) async {
    final db = await databaseProvider.db();
    int result = await db.update(dao.tableName, dao.toMap(account),
        where: dao.columnId + " = ?", whereArgs: [account.id]);
    return result;
  }

  @override
  Future<List<Account>> getList() async {
    final db = await databaseProvider.db();
    var result = await db.rawQuery("SELECT * FROM account");
    return dao.fromList(result);
  }
}
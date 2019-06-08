import 'package:ExamenParcial/infrastructure/database_provider.dart';
import 'package:ExamenParcial/model/account.dart';

abstract class AccountRepository {
  DatabaseProvider databaseProvider;
  Future<int> insert(Account course);
  Future<int> update(Account course);
  Future<int> delete(Account course);
  Future<List<Account>> getList();
}
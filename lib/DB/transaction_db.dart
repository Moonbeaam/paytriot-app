import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:paytriot/model/transaction.dart' as trans;

trans.Transaction Transaction= Transaction;
class TransactionDB {
  static final TransactionDB instance = TransactionDB._init();

  static Database? _database;

  TransactionDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('Transaction.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final amountType = 'INT NOT NULL';
    final dateType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE Transactions (
      id $idType,
      amount $amountType,
      date $dateType
    )
    ''');
  }

  Future<Map<String, dynamic>> insert(trans.Transaction transaction) async {
    final db = await instance.database;
    final id = await db.insert('Transactions', transaction.toMap());
    return {'id': id, 'amount': transaction.amount, 'date': transaction.date};
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await instance.database;
    return await db.query('Transactions');
  }

  Future<List<trans.Transaction>> getTransactions() async {
    final List<Map<String, dynamic>> transactionList = await queryAll();
    return transactionList.map((transactionMap) {
      return trans.Transaction.fromMap(transactionMap);
    }).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}


import 'package:path/path.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:sqflite/sqflite.dart';

class StudAccDB {
  static final StudAccDB instance = StudAccDB._init();

  static Database? _database;
  StudAccDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('StudAcc.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final studNumType = ' TEXT PRIMARY KEY NOT NULL';
    final lastNameType = ' TEXT NOT NULL';
    final firstNameType = ' TEXT NOT NULL';
    final middleNameType = ' TEXT';
    final balanceType = ' INTEGER DEFAULT 0';

    await db.execute('''
    CREATE TABLE $tableStudAcc(
      ${StudAccFields.studNum} $studNumType,
      ${StudAccFields.lastName} $lastNameType,
      ${StudAccFields.firstName} $firstNameType,
      ${StudAccFields.middleName} $middleNameType,
      ${StudAccFields.balance} $balanceType
    )
    ''');
  }

  Future<StudAcc> create(StudAcc studacc) async {
    final db = await instance.database;

    final studNum = await db.insert(tableStudAcc, studacc.toJson());
    return studacc.copy(studNum: (studNum.toString()));
  }

  Future<List<StudAcc>> getAllAccounts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableStudAcc);

    return List.generate(maps.length, (index) {
      return StudAcc.fromJson(maps[index]);
    });
  }

  Future<StudAcc> readAcc(String studNum) async {
    final db = await instance.database;
    final maps = await db.query(
      tableStudAcc,
      columns: StudAccFields.values,
      where: '${StudAccFields.studNum}= ?',
      whereArgs: [studNum],
    );

    if (maps.isNotEmpty) {
      return StudAcc.fromJson(maps.first);
    } else {
      throw Exception('Student Number $studNum not found');
    }
  }

  Future<void> updateBalance(int newBalance, String studNum) async {
    final Database db = await instance.database;

    // Update the balance column for a specific row with the given id
    await db.update(
      tableStudAcc,
      {StudAccFields.balance: newBalance},
      where: '${StudAccFields.studNum}= ?',
      whereArgs: [studNum],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

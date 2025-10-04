import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/ticket.dart';
import '../models/movie.dart';

class TicketDatabase {
  static final TicketDatabase instance = TicketDatabase._init();
  static Database? _database;

  TicketDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tickets.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tickets (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      movie_title TEXT NOT NULL,
      poster_url TEXT NOT NULL,
      show_time TEXT NOT NULL,
      seat TEXT NOT NULL,
      price REAL NOT NULL,
      status INTEGER NOT NULL
    )
    ''');
  }

  Future<void> insertTicket(Ticket ticket) async {
    final db = await database;
    final id = await db.insert('tickets', ticket.toMap());
    tickets.add(ticket.copyWith(id: id));
  }

  Future<void> deleteTicket(Ticket ticket) async {
    final db = await database;
    await db.delete('tickets', where: 'id = ?', whereArgs: [ticket.id]);
    tickets.removeWhere((t) => t.id == ticket.id);
  }

  Future<List<Ticket>> getAllTickets() async {
    final db = await database;
    final result = await db.query('tickets');
    return result.map((map) => Ticket.fromMap(map)).toList();
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}

Future<void> initializeTickets() async {
  final db = TicketDatabase.instance;
  tickets = await db.getAllTickets();
}

extension on Ticket {
  Ticket copyWith({int? id}) {
    return Ticket(
      id: id ?? this.id,
      movie: movie,
      showTime: showTime,
      seat: seat,
      price: price,
      status: status,
    );
  }
}

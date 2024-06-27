import 'package:flutter/material.dart';
import 'package:gym_tracker_app/screens/exercises.dart';
import 'package:gym_tracker_app/screens/home.dart';
import 'package:gym_tracker_app/screens/profile.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDatabase() async {
  // Obtén el directorio de la base de datos
  final String databasePath = await getDatabasesPath();
  final String path = join(databasePath, 'gym.db');

  await deleteDatabase(path);

  // Abre la base de datos
  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      // Crear la tabla cuando la base de datos es creada por primera vez
      return await db.execute(
        'CREATE TABLE excercises(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
      );
    },
  );
}

void main() async {
  runApp(const MyApp());
  final db = await initDatabase();
  await db.rawInsert('INSERT INTO excercises (name) VALUES (?)', ['pecho']);
  final result = await db.rawQuery('SELECT * FROM excercises');
  print(result);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 86, 151, 255),
        ),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Gym Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;

  void onPageChange(int value) {
    setState(() {
      _currentPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: _currentPage == 0
          ? const HomePage()
          : _currentPage == 1
              ? const ExcercisePage()
              : const ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (int value) => onPageChange(value),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Excercise',
            icon: Icon(Icons.sports_gymnastics),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}

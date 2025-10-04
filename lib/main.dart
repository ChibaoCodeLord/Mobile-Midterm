import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/ticket_history_screen.dart';
import 'db/ticket_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeTickets();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Ticket App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> _screens = const [HomeScreen(), TicketHistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: Builder(
        builder: (BuildContext navigatorContext) {
          return BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              if (index != currentIndex) {
                setState(() {
                  currentIndex = index;
                });
                Navigator.popUntil(navigatorContext, (route) => route.isFirst);
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Phim"),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: "Vé",
              ),
            ],
          );
        },
      ),
    );
  }
}

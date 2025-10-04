import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/ticket_history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [HomeScreen(), TicketHistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Ticket App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Phim"),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: "Vé",
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'tournament.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocalScore',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 183, 22, 22)),
      ),
      home: const MyHomePage(title: 'Turniri'),
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
  final List<Tournament> tournaments = [
    const Tournament(
      id: '1',
      name: 'Turnir 1',
      location: 'Split',
      sport: 'Nogomet',
    ),
    const Tournament(
      id: '2',
      name: 'Turnir 2',
      location: 'Zagreb',
      sport: 'Kosarka',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: tournaments.length,
        itemBuilder: (context, index) {
          final tournament = tournaments[index];
          return ListTile(
            leading: const Icon(Icons.emoji_events),
            title: Text(tournament.name),
            subtitle: Text(tournament.location),
            trailing: Text(tournament.sport),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Dodaj turnir',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

import 'addTournament.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocalScore',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 183, 22, 22),
        ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tournaments')
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final tournaments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: tournaments.length,

            itemBuilder: (context, index) {
              final document = tournaments[index];

              final data = document.data() as Map<String, dynamic>;

              final currentTeams = data['currentTeams'] as int;
              final maxTeams = data['maxTeams'] as int;

              final registrationDeadLine =
                  (data['registrationDeadLine'] as Timestamp).toDate();

              return ListTile(
                //onTap: (),

                leading: const Icon(Icons.emoji_events),
                title: Text(data['name']),
                subtitle: Text(data['location']),
                trailing: Text(data['sport']),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTournament()),
          );
        },
        tooltip: 'Dodaj turnir',
        child: const Icon(Icons.add),
      ),
    );
  }
}

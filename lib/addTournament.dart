import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTournament extends StatefulWidget {
  const AddTournament({super.key});

  @override
  State<AddTournament> createState() => _AddTournamentState();
}

class _AddTournamentState extends State<AddTournament> {
  int? selectedMaxTeams;
  String? selectedSport;
  DateTime? registrationDeadLine;

  final nameController = TextEditingController();
  final locationController = TextEditingController();

  final sports = ['Nogomet', 'Rukomet', 'Košarka', 'Tenis', 'Padel', 'Ostalo'];

  Future<void> saveTournament() async {
    if (nameController.text.isEmpty ||
        locationController.text.isEmpty ||
        selectedSport == null ||
        selectedMaxTeams == null ||
        registrationDeadLine == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Popuni sva polja')));

      return;
    }

    await FirebaseFirestore.instance.collection('tournaments').add({
      'name': nameController.text,
      'location': locationController.text,
      'sport': selectedSport,
      'maxTeams': selectedMaxTeams,
      'currentTeams': 0,
      'registrationDeadLine': registrationDeadLine,
    });

    setState(() {
      nameController.clear();
      locationController.clear();
      selectedSport = null;
      selectedMaxTeams = null;
      registrationDeadLine = null;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Turnir uspješno kreiran!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dodaj turnir')),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Naziv turnira'),
              ),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Lokacija'),
              ),
              DropdownButtonFormField<String>(
                initialValue: selectedSport,
                decoration: const InputDecoration(labelText: 'Sport'),
                items: sports.map((sport) {
                  return DropdownMenuItem<String>(
                    value: sport,
                    child: Text(sport),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSport = value;
                  });
                },
              ),
              DropdownButtonFormField<int>(
                initialValue: selectedMaxTeams,
                decoration: const InputDecoration(
                  labelText: 'Maksimalan broj ekipa',
                ),
                items: [4, 8, 12, 16, 20, 24, 32, 48, 64]
                    .map(
                      (number) => DropdownMenuItem(
                        value: number,
                        child: Text('$number'),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMaxTeams = value;
                  });
                },
              ),

              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Datum završetka prijava',
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                controller: TextEditingController(
                  text: registrationDeadLine == null
                      ? ''
                      : '${registrationDeadLine!.day}.${registrationDeadLine!.month}.${registrationDeadLine!.year}.',
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2090),
                    initialDate: DateTime.now(),
                  );

                  if (date != null) {
                    setState(() {
                      registrationDeadLine = date;
                    });
                  }
                },
              ),

              ElevatedButton(onPressed: saveTournament, child: Text('Spremi')),
            ],
          ),
        ),
      ),
    );
  }
}

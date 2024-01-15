import 'package:flutter/material.dart';
import 'package:recordatoris_app/utils/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SimpleAppPage extends StatefulWidget {
  const SimpleAppPage({Key? key}) : super(key: key);

  @override
  _SimpleAppPageState createState() => _SimpleAppPageState();
}

class _SimpleAppPageState extends State<SimpleAppPage> {
  TextEditingController _reminderController = TextEditingController();
  List<String> reminders = [];

  final supabase = SupabaseClient(
    'https://trxtizuxzaxzlcyeboll.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRyeHRpenV4emF4emxjeWVib2xsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ3MjU4MTAsImV4cCI6MjAyMDMwMTgxMH0.9tkzmEv1VXhaFTjnURT9zmKgroNdZ4J2ZriD9wulOTw',
  );

  @override
  void initState() {
    super.initState();
    _fetchReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                // Cambié `client` a `supabase` aquí
                supabase.auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context, '/', (route) => false
                );
              },
              icon: const Icon(Icons.logout),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_month_rounded,
              size: 150,
              color: Colors.blue,
            ),
            smallGap,
            Text(
              // Cambié `client` a `supabase` aquí
              'Welcome ${client.auth.currentUser?.email}',
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
            largeGap,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _reminderController,
                decoration: const InputDecoration(labelText: 'Enter Reminder'),
              ),
            ),
            smallGap,
            ElevatedButton(
              onPressed: () async {
                await saveReminder(); // Cambié al método saveReminder
              },
              child: const Text('Add Reminder'),
            ),
            largeGap,
            Expanded(
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(reminders[index]),
                  );
                },
              ),
            ),
            largeGap,
            OutlinedButton(
              onPressed: () {
                // Cambié `client` a `supabase` aquí
                supabase.auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context, '/', (route) => false
                );
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchReminders() async {
    final response = await supabase
        .from('recordatorios')
        .select()
        .eq('id_usuario', client.auth.currentUser?.id)
        .execute();

    if (response.error == null && response.data != null) {
      setState(() {
        reminders = List<String>.from(response.data!
            .map((recordatorio) => recordatorio['recordatorio'] as String));
      });
    }
  }

  Future<void> saveReminder() async {
    final name = _reminderController.text;

    if (name.isNotEmpty) {
      final response = await supabase.from('recordatorios').upsert([
        {'recordatorio': name, 'id_usuario': client.auth.currentUser?.id},
      ]).execute();
      _reminderController.clear();

      // Actualizar la lista de recordatorios después de agregar uno nuevo
      _fetchReminders();
      if (response.error == null) {
        print('Reminder saved successfully!');
      } else {
        print('Error saving reminder: ${response.error!.message}');
      }
    } else {
      print('Reminder cannot be empty.');
    }
  }
}

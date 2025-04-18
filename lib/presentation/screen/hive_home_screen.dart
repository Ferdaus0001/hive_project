import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HiveHomeScreen extends StatefulWidget {
  const HiveHomeScreen({super.key});

  @override
  State<HiveHomeScreen> createState() => _HiveHomeScreenState();
}

class _HiveHomeScreenState extends State<HiveHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 44),
        child: FutureBuilder(
          future: Hive.openBox('ferdaus'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            var box = snapshot.data as Box;
            var jobData = box.get('list');
            var food = box.get('food');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Job: ${jobData?['job'] ?? 'No job'}"),
                Text("Salary: ${jobData?['salary'] ?? 'No salary'}"),
                Text("Food: ${food ?? 'No food'}"),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('ferdaus'); // ✅ একই Box
          await box.put('food', 'apple, mango');
          await box.put('list', {
            'job': 'developer',
            'salary': 222,
          });

          print(box.get('list')?['job']);
          print(box.get('food'));

          setState(() {}); // ✅ UI refresh
        },
        child: const Icon(Icons.add, size: 41),
      ),
    );
  }
}

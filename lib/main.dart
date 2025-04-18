import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // ✅ use hive_flutter for Flutter apps
import 'package:hive_project/presentation/screen/hive_home_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();

  // ✅ Initialize Hive for Flutter
  await Hive.initFlutter();

  // ✅ Optional: open a box before running the app
  await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Hive Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HiveHomeScreen(),
    );
  }
}

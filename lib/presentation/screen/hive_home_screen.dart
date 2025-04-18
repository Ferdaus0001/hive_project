import 'package:flutter/material.dart';
class HiveHomeScreen extends StatefulWidget {
  const HiveHomeScreen({super.key});

  @override
  State<HiveHomeScreen> createState() => _HiveHomeScreenState();
}

class _HiveHomeScreenState extends State<HiveHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add,size: 41,),),
    );
  }
}

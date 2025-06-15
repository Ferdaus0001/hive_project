import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../data_base/boxes/boxes.dart';
import '../data_base/models/notes_model.dart';
class HiveHomeScreen extends StatefulWidget {
  const HiveHomeScreen({super.key});

  @override
  State<HiveHomeScreen> createState() => _HiveHomeScreenState();
}

class _HiveHomeScreenState extends State<HiveHomeScreen> {
  final titelController = TextEditingController();
  final subtitleController = TextEditingController();
  final box = Hive.box<NotesModel>('notes');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 11,vertical: 22,),
        child: ValueListenableBuilder(valueListenable: Boxes.getData().listenable(), builder: ( context, Box<NotesModel> box, _){
          return  ListView.builder(
            itemCount: 5,
              itemBuilder: (context , indext){
            return  Card(
              child: Column(
                children: [],
              ),
            );
          });
        }),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
          setState(() {
            _showDialogBox();
          });

      },child: Icon(Icons.add),),
    );
    
  }

  Future<void> _showDialogBox() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titelController, // বানান ঠিক করা
                  decoration: InputDecoration(
                    hintText: 'Add title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
                SizedBox(height: 10), // vertical space
                TextFormField(
                  controller: subtitleController, // নতুন controller ব্যবহার করা হয়েছে
                  decoration: InputDecoration(
                    hintText: 'Add subtitle',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final data = NotesModel(title: titelController.text, subtitle: subtitleController.text);
                final box = Boxes.getData();
                box.add(data);
                data.save();
                titelController.dispose();
                subtitleController.dispose();
                Navigator.of(context).pop(); // ডায়ালগ বন্ধ করতে
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ডায়ালগ বন্ধ করতে
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
  
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_project/presentation/hive_helper/box_helper.dart';
import 'package:hive_project/presentation/hive_helper/notes_models.dart';

class HiveHomeScreen extends StatefulWidget {
  const HiveHomeScreen({super.key});

  @override
  State<HiveHomeScreen> createState() => _HiveHomeScreenState();
}

final titleController = TextEditingController();
final edittitleController = TextEditingController();
final descrController = TextEditingController();
final editdescrController = TextEditingController();

class _HiveHomeScreenState extends State<HiveHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hive Notes")),
      body: ValueListenableBuilder(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, Box<NotesModel> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final note = box.getAt(index);
              return ListTile(
                title: Text(note?.title ?? ''),
                subtitle: Text(note?.description ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _editDialog(context, note!, note.title, note.description, index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        note?.delete();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMyDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text('Add Note'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: descrController,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final data = NotesModel(
                title: titleController.text,
                description: descrController.text,
              );
              final box = Boxes.getData();
              box.add(data);
              titleController.clear();
              descrController.clear();
              Get.back();
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}

Future<void> _editDialog(BuildContext context, NotesModel note, String title, String description, int index) async {
  edittitleController.text = title;
  editdescrController.text = description;

  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text('Edit Note'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: edittitleController,
                decoration: InputDecoration(
                  hintText: 'Edit Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: editdescrController,
                decoration: InputDecoration(
                  hintText: 'Edit Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final data = NotesModel(
                title: edittitleController.text,
                description: editdescrController.text,
              );
              final box = Boxes.getData();
              box.putAt(index, data); // Update the note at the specific index
              edittitleController.clear();
              editdescrController.clear();
              Get.back();
            },
            child: Text('Update'),
          ),
        ],
      );
    },
  );
}

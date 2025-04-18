import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_project/presentation/hive_helper/notes_models.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
}

import 'package:hive_flutter/hive_flutter.dart';

part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject{
  @HiveField(0)
  String title;

  @HiveField(1)
  String subtitle; // 🔁 Subtilte -> subtitle (ভুল বানান ঠিক করা হয়েছে)

  NotesModel({required this.title, required this.subtitle});
}

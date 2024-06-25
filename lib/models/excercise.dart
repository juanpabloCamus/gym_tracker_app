import 'package:gym_tracker_app/models/record.dart';

class Excercise {
  final String name;
  final String? description;
  final List<Record> records;

  Excercise(this.name, this.description, this.records);
}

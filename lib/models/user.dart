import 'package:isar/isar.dart';
part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  late String name;
  late String lastName;
  late String birthDate;
}

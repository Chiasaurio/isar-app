import 'package:dv_test/models/user.dart';
import 'package:isar/isar.dart';

part 'direccion.g.dart';

@collection
class Direccion {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  late String direccion;

  final usuario = IsarLink<User>();
}

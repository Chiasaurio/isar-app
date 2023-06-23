import 'package:dv_test/models/direccion.dart';
import 'package:dv_test/models/user.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveDireccion(Direccion direccion) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.direccions.putSync(direccion));
  }

  Future<List<Direccion>> getUserDirecciones(int idUsuario) async {
    final isar = await db;
    return await isar.direccions
        .filter()
        .usuario((q) => q.idEqualTo(idUsuario))
        .findAll();
  }

  Future<int> saveUser(User newUser) async {
    final isar = await db;
    final id = await isar.writeTxn(() async {
      return await isar.users.put(newUser);
    });
    return id;
  }

  Future<User?> getUserFor(int id) async {
    final isar = await db;
    final user = await isar.users.get(id);
    return user;
  }

  Future<List<User>> getAllUsers() async {
    final isar = await db;
    return await isar.users.where().findAll();
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Stream<List<User>> watchUsers() async* {
    final isar = await db;
    Stream<List<User>> userChanged =
        isar.users.where().watch(fireImmediately: true);

    yield* userChanged;
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [UserSchema, DireccionSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
}

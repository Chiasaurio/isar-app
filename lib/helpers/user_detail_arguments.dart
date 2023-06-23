import 'package:dv_test/models/direccion.dart';
import 'package:dv_test/models/user.dart';

class UserInfoArguments {
  final User usuario;
  final List<Direccion> direcciones;

  UserInfoArguments(this.usuario, this.direcciones);
}

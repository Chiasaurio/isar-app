import 'package:dv_test/helpers/user_detail_arguments.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UserInfoArguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nombre',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(args.usuario.name),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Apellido',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(args.usuario.lastName),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Fecha de nacimiento',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(args.usuario.birthDate),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Direcciones',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: args.direcciones
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(e.direccion),
                        ))
                    .toList()),
          ],
        ),
      ),
    );
  }
}

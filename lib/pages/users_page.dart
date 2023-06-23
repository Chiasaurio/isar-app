import 'package:dv_test/isar_service.dart';
import 'package:dv_test/models/user.dart';
import 'package:dv_test/widgets/user_info.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});
  final service = IsarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: StreamBuilder<List<User>>(
                stream: service.watchUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                        children: snapshot.data!
                            .map((e) => UserInfo(
                                  user: e,
                                  service: service,
                                ))
                            .toList());
                  } else {
                    return const Text('No hay usuarios registrados');
                  }
                },
              ),
            ),

            //
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/create-user');
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Registrar nuevo usuario'),
                ),
                ElevatedButton(
                  onPressed: () {
                    service.cleanDb();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                        fontSize: 14,
                      )),
                  child: const Text('Limpiar db'),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

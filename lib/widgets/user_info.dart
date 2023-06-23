import 'package:dv_test/helpers/user_detail_arguments.dart';
import 'package:dv_test/isar_service.dart';
import 'package:dv_test/models/direccion.dart';
import 'package:dv_test/models/user.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  final User user;
  final IsarService service;

  const UserInfo({required this.user, super.key, required this.service});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  List<Direccion>? direcciones = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(children: [
              Text(widget.user.name),
            ]),
          ),
          Expanded(
            child: Column(children: [
              Text(widget.user.lastName),
            ]),
          ),
          // Expanded(
          //   child: Column(children: [
          //     FutureBuilder(
          //       future: widget.service.getUserDirecciones(widget.user.id),
          //       builder: (context, snapshot) {
          //         if (snapshot.hasData) {
          //           direcciones = snapshot.data!;
          //           return Text(snapshot.data!.length.toString());
          //         } else {
          //           return const Text('');
          //         }
          //       },
          //     )
          //   ]),
          // ),
          Expanded(
            child: Column(children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/user-detail',
                        arguments:
                            UserInfoArguments(widget.user, direcciones!));
                  },
                  child: const Text('Ver info'))
            ]),
          ),
        ],
      ),
    );
  }
}

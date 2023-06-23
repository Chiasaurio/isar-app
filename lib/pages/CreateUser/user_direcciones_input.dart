import 'package:flutter/material.dart';

class UserDireccionesInput extends StatefulWidget {
  final List<TextEditingController> controllers;
  const UserDireccionesInput({super.key, required this.controllers});

  @override
  State<UserDireccionesInput> createState() => _UserDireccionesInputState();
}

class _UserDireccionesInputState extends State<UserDireccionesInput> {
  // ignore: prefer_final_fields
  late List<Widget> _fields;
  @override
  void initState() {
    _fields = [
      TextFormField(
        controller: widget.controllers[0],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Dirección 1',
        ),
        validator: (value) =>
            value == null || value == '' ? 'Este campo es requerido' : null,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(children: _fields.map((e) => e).toList()),
        TextButton(
            onPressed: () {
              final controller = TextEditingController();
              final field = Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Dirección ${_fields.length + 1}',
                  ),
                  validator: (value) => value == null || value == ''
                      ? 'Este campo es requerido'
                      : null,
                ),
              );

              setState(() {
                widget.controllers.add(controller);
                _fields.add(field);
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.add),
                Text('Agregar otra dirección'),
              ],
            )),
      ],
    );
  }
}

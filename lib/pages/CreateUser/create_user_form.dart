import 'package:dv_test/isar_service.dart';
import 'package:dv_test/models/direccion.dart';
import 'package:dv_test/models/user.dart';
import 'package:dv_test/pages/CreateUser/user_direcciones_input.dart';
import 'package:flutter/material.dart';

class CreateUserForm extends StatefulWidget {
  const CreateUserForm({super.key, required this.service});
  final IsarService service;
  @override
  State<CreateUserForm> createState() => _CreateUserFormState();
}

class _CreateUserFormState extends State<CreateUserForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _inputFieldDateController =
      TextEditingController();
  // ignore: prefer_final_fields
  List<TextEditingController> _direccionesControllers = [
    TextEditingController()
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2024));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _inputFieldDateController.text =
            selectedDate!.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _inputFieldDateController.dispose();
    for (final controller in _direccionesControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Por favor ingrese los datos del usuario',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nombre',
              ),
              validator: (value) => value == null || value == ''
                  ? 'Este campo es requerido'
                  : null,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _apellidoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Apellido',
              ),
              validator: (value) => value == null || value == ''
                  ? 'Este campo es requerido'
                  : null,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _inputFieldDateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Fecha de nacimiento',
              ),
              readOnly: true,
              enableInteractiveSelection: false,
              validator: (value) => value == null || value == ''
                  ? 'Este campo es requerido'
                  : null,
              onTap: () {
                _selectDate(context);
              },
            ),
            const SizedBox(
              height: 5,
            ),
            UserDireccionesInput(controllers: _direccionesControllers),
            ElevatedButton.icon(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final usuarioId = await widget.service.saveUser(User()
                    ..name = _nombreController.text
                    ..lastName = _apellidoController.text
                    ..birthDate = _inputFieldDateController.text);

                  final usuario = await widget.service.getUserFor(usuarioId);
                  for (var direccion in _direccionesControllers) {
                    await widget.service.saveDireccion(Direccion()
                      ..direccion = direccion.text
                      ..usuario.value = usuario);
                  }
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                          "Nuevo usuario '${_nombreController.text}' guardado en la DB")));

                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Finalizar registro'),
            )
          ],
        ),
      ),
    );
  }
}
